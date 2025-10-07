// lib/services/pdf_generator.dart

import 'dart:typed_data';
import 'package:accountbook/models/invoice_model.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfGenerator {

  // =================================================================
  // CLASSIC INVOICE IMPLEMENTATION
  // =================================================================
  static Future<Uint8List> generateClassicInvoice(InvoiceData data) async {
    final pdf = pw.Document(theme: pw.ThemeData.withFont(
      base: await PdfGoogleFonts.openSansRegular(),
      bold: await PdfGoogleFonts.openSansBold(),
    ));

    final qrCode = _buildQrCode('E-Invoice Data Placeholder');
    final upiQrCode = _buildQrCode('upi://pay?pa=${data.upiId}&pn=${data.companyName}&am=${data.totalAmount}');

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
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          pw.Center(child: pw.Text('TAX INVOICE', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 8),
          pw.Center(child: pw.Text(data.companyName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14))),
          pw.Center(child: pw.Text(data.companyAddress.replaceAll('\n', ', '), style: const pw.TextStyle(fontSize: 9))),
           pw.SizedBox(height: 12),
          _tallyBuildPartyAndInvoiceDetails(data),
          pw.SizedBox(height: 12),
          _tallyBuildItemTable(data),
          pw.SizedBox(height: 12),
          _tallyBuildTotals(data),
          pw.SizedBox(height: 20),
          _classicBuildTermsAndSignature(data),
        ]
      )
    );
    return pdf.save();
  }

   static pw.Widget _tallyBuildPartyAndInvoiceDetails(InvoiceData data) {
    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {0: const pw.FlexColumnWidth(1), 1: const pw.FlexColumnWidth(1)},
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _detailRow('Invoice No.', data.invoiceNumber, fontSize: 9),
                  _detailRow('Date', DateFormat('dd-MMM-yy').format(data.invoiceDate), fontSize: 9),
                ]
              )
            ),
             pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Column(
                 crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _detailRow('Mode/Terms of Payment', '', fontSize: 9),
                   _detailRow('Other Reference(s)', '', fontSize: 9),
                ]
              )
            )
          ]
        ),
        pw.TableRow(
          children: [
             pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Buyer', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
                  pw.Text(data.buyerName, style: const pw.TextStyle(fontSize: 9)),
                  pw.Text(data.buyerAddress, style: const pw.TextStyle(fontSize: 9)),
                  pw.Text('GSTIN/UIN: ${data.buyerGstin}', style: const pw.TextStyle(fontSize: 9)),
                ]
              )
            ),
             pw.Padding(
              padding: const pw.EdgeInsets.all(4),
              child: pw.Column(
                 crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                   _detailRow('Despatch Doc No.', '', fontSize: 9),
                   _detailRow('Delivery Note Date', '', fontSize: 9),
                   _detailRow('Despatched through', data.transporterName, fontSize: 9),
                   _detailRow('Destination', '', fontSize: 9),
                ]
              )
            )
          ]
        )
      ]
    );
  }

  static pw.Widget _tallyBuildItemTable(InvoiceData data) {
      const tableHeaders = ['Sr. No.', 'Description of Goods', 'HSN/SAC', 'Quantity', 'Rate', 'per', 'Amount'];
      return pw.Table.fromTextArray(
        headers: tableHeaders,
        data: data.items.map((item) => [
          item.srNo.toString(),
          item.name,
          item.hsnSac,
          '${item.quantity.toStringAsFixed(2)} ${item.unit}',
          item.rate.toStringAsFixed(2),
          item.unit,
          (item.quantity * item.rate).toStringAsFixed(2),
        ]).toList(),
        border: pw.TableBorder.all(),
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
        cellStyle: const pw.TextStyle(fontSize: 9),
        cellAlignments: {
           0: pw.Alignment.center,
           1: pw.Alignment.centerLeft,
           2: pw.Alignment.center,
           3: pw.Alignment.centerRight,
           4: pw.Alignment.centerRight,
           5: pw.Alignment.center,
           6: pw.Alignment.centerRight,
        }
      );
  }

  static pw.Widget _tallyBuildTotals(InvoiceData data) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Amount Chargeable (in words)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)),
              pw.Text(data.totalAmountInWords, style: const pw.TextStyle(fontSize: 9)),
            ]
          )
        ),
        pw.Table(
          columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(1)},
          children: [
            pw.TableRow(children: [pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)), pw.Text(data.items.fold<double>(0, (sum, item) => sum + item.rate * item.quantity).toStringAsFixed(2), textAlign: pw.TextAlign.right, style: const pw.TextStyle(fontSize: 9))]),
            pw.TableRow(children: [pw.Text('IGST', style: pw.TextStyle(fontSize: 9)), pw.Text(data.items.fold<double>(0, (sum, item) => sum + item.igstAmount).toStringAsFixed(2), textAlign: pw.TextAlign.right, style: const pw.TextStyle(fontSize: 9))]),
             pw.TableRow(children: [pw.Text('Total Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)), pw.Text(data.totalAmount.toStringAsFixed(2), textAlign: pw.TextAlign.right, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9))]),

          ]
        )
      ]
    );
  }

  // =================================================================
  // CLEAN INVOICE IMPLEMENTATION
  // =================================================================
  static Future<Uint8List> generateCleanInvoice(InvoiceData data) async {
    final pdf = pw.Document();
     pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
               pw.Text('INVOICE', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24, color: PdfColors.blueGrey)),
               pw.Text(data.companyName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16)),
            ]
          ),
          pw.Divider(height: 20),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Billed To', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text(data.buyerName),
                  pw.Text(data.buyerAddress),
                  pw.Text('GSTIN: ${data.buyerGstin}'),
                ]
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  _detailRow('Invoice #', data.invoiceNumber),
                  _detailRow('Invoice Date', DateFormat('dd MMM, yyyy').format(data.invoiceDate)),
                ]
              ),
            ]
          ),
           pw.SizedBox(height: 30),
            _cleanBuildItemTable(data),
            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    _totalRow('Subtotal', data.items.fold<double>(0, (sum, item) => sum + item.taxableValue).toStringAsFixed(2)),
                    _totalRow('Tax (IGST)', data.items.fold<double>(0, (sum, item) => sum + item.igstAmount).toStringAsFixed(2)),
                    pw.Divider(),
                     _totalRow('Total', data.totalAmount.toStringAsFixed(2), isBold: true),
                  ]
                )
              ]
            ),
             pw.SizedBox(height: 40),
             pw.Text('Thank you for your business!', style: const pw.TextStyle(color: PdfColors.grey)),
        ]
      )
    );
    return pdf.save();
  }

  static pw.Widget _cleanBuildItemTable(InvoiceData data) {
     const tableHeaders = ['Description', 'Qty', 'Unit Price', 'Total'];
      return pw.Table.fromTextArray(
        headers: tableHeaders,
        data: data.items.map((item) => [
          item.name,
          item.quantity.toString(),
          item.rate.toStringAsFixed(2),
          item.total.toStringAsFixed(2),
        ]).toList(),
        border: null,
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.blueGrey, fontSize: 10),
        headerDecoration: const pw.BoxDecoration(border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey))),
        cellStyle: const pw.TextStyle(fontSize: 10),
        cellAlignments: {
           0: pw.Alignment.centerLeft,
           1: pw.Alignment.centerRight,
           2: pw.Alignment.centerRight,
           3: pw.Alignment.centerRight,
        }
      );
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
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: <pw.Widget>[
                pw.Text('TAX INVOICE', textScaleFactor: 1.5, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                _buildQrCode('E-Invoice Data Placeholder')
              ],
            ),
          ),
          pw.Row(
             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
             crossAxisAlignment: pw.CrossAxisAlignment.start,
             children: [
                pw.Expanded(child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(data.companyName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(data.companyAddress),
                    pw.Text('GSTIN: ${data.companyGstin}'),
                  ]
                )),
                pw.SizedBox(width: 20),
                pw.Expanded(child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                     _detailRow('Invoice No.', data.invoiceNumber),
                     _detailRow('Date', DateFormat('dd/MM/yyyy').format(data.invoiceDate)),
                  ]
                )),
             ]
          ),
          pw.Divider(height: 20),
          _detailedItemTable(data),
          pw.SizedBox(height: 20),
          _classicBuildTotalsAndBankDetails(data, _buildQrCode('upi://pay?pa=${data.upiId}&pn=${data.companyName}&am=${data.totalAmount}')),
          pw.SizedBox(height: 20),
          _classicBuildTermsAndSignature(data),

        ]
      )
    );
    return pdf.save();
  }

  static pw.Widget _detailedItemTable(InvoiceData data) {
    const tableHeaders = ['Sr.No', 'Product', 'HSN', 'Qty', 'Rate', 'Taxable', 'CGST', 'SGST', 'IGST', 'CESS', 'Total'];
     return pw.Table.fromTextArray(
        headers: tableHeaders,
        data: data.items.map((item) => [
          item.srNo.toString(),
          item.name,
          item.hsnSac ?? '',
          item.quantity.toString(),
          item.rate.toStringAsFixed(2),
          item.taxableValue.toStringAsFixed(2),
          item.cgstAmount.toStringAsFixed(2),
          item.sgstAmount.toStringAsFixed(2),
          item.igstAmount.toStringAsFixed(2),
          '0.00', // CESS
          item.total.toStringAsFixed(2),
        ]).toList(),
        border: pw.TableBorder.all(),
        headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8),
        cellStyle: const pw.TextStyle(fontSize: 8),
        headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
        cellAlignments: {
          for (var i = 0; i < tableHeaders.length; i++) i: (i == 1 ? pw.Alignment.centerLeft : pw.Alignment.centerRight),
          0: pw.Alignment.center,
        },
     );
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

  static pw.Widget _detailRow(String label, String value, {bool boldValue = false, double fontSize = 9}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('$label:', style: pw.TextStyle(fontSize: fontSize, color: PdfColors.grey700)),
          pw.Text(value, style: pw.TextStyle(fontWeight: boldValue ? pw.FontWeight.bold : pw.FontWeight.normal, fontSize: fontSize)),
        ],
      ),
    );
  }

  static pw.Widget _totalRow(String label, String value, {bool isBold = false}) {
    final style = pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal, fontSize: 9);
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 3),
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
