// lib/services/pdf_generator.dart

import 'dart:typed_data';
import 'package:accountbook/models/invoice_model.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {
  // --- MASTER GENERATION FUNCTION ---
  static Future<Uint8List> generate(String template, InvoiceData data) async {
    switch (template) {
      case 'Tally':
        return generateTallyInvoice(data);
      case 'Clean':
        return generateCleanInvoice(data);
      case 'Detailed':
        return generateDetailedInvoice(data);
      case 'Classic':
      default:
        return generateClassicInvoice(data);
    }
  }

  // =================================================================
  // CLASSIC INVOICE IMPLEMENTATION
  // =================================================================
  static Future<Uint8List> generateClassicInvoice(InvoiceData data) async {
    final pdf = pw.Document(theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
    ));

    final qrCode = _buildQrCode('E-Invoice Data Placeholder');
    final upiQrCode = _buildQrCode('upi://pay?pa=${data.upiId}&pn=PayeeName&am=${data.totalAmount}');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) => [
          _classicBuildHeader(data, qrCode),
          pw.SizedBox(height: 12),
          pw.Center(child: pw.Text('TAX INVOICE', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12))),
          pw.SizedBox(height: 12),
          _classicBuildPartyAndInvoiceDetails(data),
          pw.SizedBox(height: 20),
          _classicBuildItemTable(data),
          pw.SizedBox(height: 12),
          _classicBuildTotalsAndBankDetails(data, upiQrCode),
          pw.SizedBox(height: 20),
          _classicBuildTermsAndSignature(data),
        ],
      ),
    );

    return pdf.save();
  }

  // --- Classic Template Widgets ---

  static pw.Widget _classicBuildHeader(InvoiceData data, pw.BarcodeWidget qrCode) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(), color: PdfColors.grey200),
      padding: const pw.EdgeInsets.all(8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(data.companyName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
              pw.SizedBox(height: 4),
              pw.Text(data.companyAddress, style: const pw.TextStyle(fontSize: 8)),
              pw.SizedBox(height: 4),
              pw.Text('GSTIN: ${data.companyGstin}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
            ],
          ),
          qrCode,
        ],
      ),
    );
  }

  static pw.Widget _classicBuildPartyAndInvoiceDetails(InvoiceData data) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      child: pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _detailRow('Invoice Number', data.invoiceNumber, boldValue: true),
                      _detailRow('Invoice Date', DateFormat('dd-MM-yyyy').format(data.invoiceDate)),
                      _detailRow('Due Date', '29-05-2023'),
                      _detailRow('PO Number', data.poNumber),
                      _detailRow('E-Way Bill Number', data.ewayBillNumber),
                    ],
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  decoration: const pw.BoxDecoration(border: pw.Border(left: pw.BorderSide())),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                       _detailRow('Transporter Name', data.transporterName),
                       _detailRow('Vehicle Number', 'CG04XX1234'),
                       _detailRow('Date of Supply', '24-05-2023'),
                    ]
                  )
                )
              )
            ]
          ),
          pw.Container(height: 1, color: PdfColors.black),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
               pw.Expanded(
                child: pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Details of Receiver | Billed to', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.SizedBox(height: 4),
                      pw.Text(data.buyerName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.Text(data.buyerAddress, style: const pw.TextStyle(fontSize: 8)),
                       pw.Text('GSTIN: ${data.buyerGstin}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
                    ],
                  ),
                ),
              ),
               pw.Expanded(
                child: pw.Container(
                   padding: const pw.EdgeInsets.all(6),
                  decoration: const pw.BoxDecoration(border: pw.Border(left: pw.BorderSide())),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Details of Consignee | Shipped to', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.SizedBox(height: 4),
                       pw.Text(data.buyerName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.Text(data.buyerAddress, style: const pw.TextStyle(fontSize: 8)),
                       pw.Text('GSTIN: ${data.buyerGstin}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
                    ],
                  ),
                ),
              ),
            ]
          )
        ]
      )
    );
  }

  static pw.Widget _classicBuildItemTable(InvoiceData data) {
    const tableHeaders = ['Sr.\nNo.', 'Name of Product', 'HSN/SAC', 'Qty', 'Unit', 'Rate', 'Discount', 'Taxable\nValue', 'IGST\nRate', 'IGST\nAmount', 'Total'];

    return pw.Table.fromTextArray(
      headers: tableHeaders,
      data: data.items.map((item) => [
        item.srNo.toString(), item.name, item.hsnSac, item.quantity.toString(), item.unit,
        item.rate.toStringAsFixed(2), '${item.discount.toStringAsFixed(2)}%', item.taxableValue.toStringAsFixed(2),
        '${item.igstRate.toStringAsFixed(2)}%', item.igstAmount.toStringAsFixed(2), item.total.toStringAsFixed(2),
      ]).toList(),
      border: pw.TableBorder.all(),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 7),
      cellStyle: const pw.TextStyle(fontSize: 7),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellAlignments: {
        0: pw.Alignment.center, 1: pw.Alignment.centerLeft, 2: pw.Alignment.center, 3: pw.Alignment.centerRight,
        4: pw.Alignment.center, 5: pw.Alignment.centerRight, 6: pw.Alignment.centerRight, 7: pw.Alignment.centerRight,
        8: pw.Alignment.centerRight, 9: pw.Alignment.centerRight, 10: pw.Alignment.centerRight,
      },
      columnWidths: {
        0: const pw.FlexColumnWidth(0.5), 1: const pw.FlexColumnWidth(2.5), 2: const pw.FlexColumnWidth(1),
        3: const pw.FlexColumnWidth(0.5), 4: const pw.FlexColumnWidth(0.5), 5: const pw.FlexColumnWidth(0.8),
        6: const pw.FlexColumnWidth(0.8), 7: const pw.FlexColumnWidth(1), 8: const pw.FlexColumnWidth(0.7),
        9: const pw.FlexColumnWidth(0.8), 10: const pw.FlexColumnWidth(1.2),
      }
    );
  }

  static pw.Widget _classicBuildTotalsAndBankDetails(InvoiceData data, pw.BarcodeWidget upiQrCode) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
               pw.Text('Total Invoice Amount in words', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
               pw.Text(data.totalAmountInWords, style: const pw.TextStyle(fontSize: 8)),
               pw.SizedBox(height: 20),
               pw.Text('Bank and Payment Details', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
               pw.Row(
                 crossAxisAlignment: pw.CrossAxisAlignment.start,
                 children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _detailRow('UPI ID', data.upiId, fontSize: 8),
                        _detailRow('Account No.', data.bankAccountNo, fontSize: 8),
                        _detailRow('Bank Name', data.bankName, fontSize: 8),
                        _detailRow('IFSC Code', data.bankIfsc, fontSize: 8),
                      ]
                    ),
                    pw.SizedBox(width: 20),
                    upiQrCode
                 ]
               )
            ]
          )
        ),
        pw.Expanded(
          flex: 1,
          child: pw.Container(
            decoration: pw.BoxDecoration(border: pw.TableBorder.all()),
            child: pw.Column(
              children: [
                 _totalRow('Sub-Total', '2,375.00'),
                 _totalRow('Add: IGST', '365.75'),
                 _totalRow('Round Off', '-0.25'),
                 _totalRow('Total Amount', data.totalAmount.toStringAsFixed(2), isBold: true),
              ]
            )
          )
        ),
      ]
    );
  }

  static pw.Widget _classicBuildTermsAndSignature(InvoiceData data) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Terms and Conditions', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
              ...data.termsAndConditions.map((e) => pw.Text(e, style: const pw.TextStyle(fontSize: 7))).toList(),
            ]
          )
        ),
         pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text('For, ${data.companyName}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
              pw.SizedBox(height: 30),
              pw.Container(height: 1, color: PdfColors.black),
              pw.Text('Authorised Signatory', style: const pw.TextStyle(fontSize: 8)),
            ]
          )
        ),
      ]
    );
  }

  // =================================================================
  // TALLY INVOICE IMPLEMENTATION
  // =================================================================
  static Future<Uint8List> generateTallyInvoice(InvoiceData data) async {
    final pdf = pw.Document();
     pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) => [
          pw.Text('Tally Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
           pw.Divider(),
           pw.SizedBox(height: 10),
           pw.Text('This is a placeholder for the Tally-style invoice format.'),
           pw.SizedBox(height: 10),
           pw.Text('The structure would be built here using Rows, Columns, and Tables similar to the Classic format, but with different styling and layout to match the Tally screenshot.')
        ]
      )
    );
    return pdf.save();
  }

  // =================================================================
  // CLEAN INVOICE IMPLEMENTATION
  // =================================================================
  static Future<Uint8List> generateCleanInvoice(InvoiceData data) async {
    final pdf = pw.Document();
     pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) => [
          pw.Text('Clean Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
           pw.Divider(),
           pw.SizedBox(height: 10),
           pw.Text('This is a placeholder for the Clean-style invoice format.'),
           pw.SizedBox(height: 10),
           pw.Text('This layout would be simpler, perhaps with more whitespace and a modern font.')
        ]
      )
    );
    return pdf.save();
  }

  // =================================================================
  // DETAILED INVOICE IMPLEMENTATION
  // =================================================================
  static Future<Uint8List> generateDetailedInvoice(InvoiceData data) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (pw.Context context) => [
          pw.Text('Detailed Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
           pw.Divider(),
           pw.SizedBox(height: 10),
           pw.Text('This is a placeholder for the Detailed-style invoice format.'),
           pw.SizedBox(height: 10),
           pw.Text('This format might include extra columns in the item table, such as batch numbers, expiry dates, or more detailed tax breakdowns (CGST, SGST).')
        ]
      )
    );
    return pdf.save();
  }


  // --- HELPER WIDGETS ---
  static pw.BarcodeWidget _buildQrCode(String data) {
    return pw.BarcodeWidget(
      barcode: pw.Barcode.qrCode(),
      data: data,
      width: 60,
      height: 60,
    );
  }

  static pw.Widget _detailRow(String label, String value, {bool boldValue = false, double fontSize = 8}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('$label:', style: pw.TextStyle(fontSize: fontSize)),
          pw.Text(value, style: pw.TextStyle(fontWeight: boldValue ? pw.FontWeight.bold : pw.FontWeight.normal, fontSize: fontSize)),
        ],
      ),
    );
  }

  static pw.Widget _totalRow(String label, String value, {bool isBold = false}) {
    final style = pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal, fontSize: 8);
    return pw.Container(
      decoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide())),
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: style),
          pw.Text('INR $value', style: style),
        ],
      ),
    );
  }
}