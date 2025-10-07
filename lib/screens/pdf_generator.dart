// lib/services/pdf_generator.dart

import 'dart:typed_data';
import 'package:accountbook/models/invoice_model.dart'; // Import the new model file
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'; // Needed for Google Fonts

class PdfGenerator {
  static Future<Uint8List> generateClassicInvoice(InvoiceData data) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.openSansRegular();
    final boldFont = await PdfGoogleFonts.openSansBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          _buildHeader(data, font, boldFont),
          pw.SizedBox(height: 20),
          _buildBuyerDetails(data, font, boldFont),
          pw.SizedBox(height: 20),
          _buildItemsTable(data, font, boldFont),
          pw.Divider(height: 20),
          _buildTotals(data, font, boldFont),
          pw.Spacer(),
          _buildFooter(data, font),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(InvoiceData data, pw.Font font, pw.Font boldFont) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(data.companyName, style: pw.TextStyle(font: boldFont, fontSize: 20)),
            pw.Text(data.companyAddress, style: pw.TextStyle(font: font, fontSize: 10)),
            pw.Text('GSTIN: ${data.companyGstin}', style: pw.TextStyle(font: font, fontSize: 10)),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text('TAX INVOICE', style: pw.TextStyle(font: boldFont, fontSize: 18, color: PdfColors.blue700)),
            pw.SizedBox(height: 10),
            pw.Text('Invoice #: ${data.invoiceNumber}', style: pw.TextStyle(font: font, fontSize: 10)),
            pw.Text('Date: ${DateFormat.yMMMd().format(data.date)}', style: pw.TextStyle(font: font, fontSize: 10)),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildBuyerDetails(InvoiceData data, pw.Font font, pw.Font boldFont) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Bill To:', style: pw.TextStyle(font: boldFont, fontSize: 12)),
        pw.SizedBox(height: 5),
        pw.Text(data.buyerName, style: pw.TextStyle(font: font, fontSize: 10)),
        pw.Text(data.buyerAddress, style: pw.TextStyle(font: font, fontSize: 10)),
        pw.Text('GSTIN: ${data.buyerGstin}', style: pw.TextStyle(font: font, fontSize: 10)),
      ],
    );
  }

  static pw.Widget _buildItemsTable(InvoiceData data, pw.Font font, pw.Font boldFont) {
    const tableHeaders = ['#', 'Item Description', 'Qty', 'Unit Price', 'Tax', 'Total'];
    
    return pw.Table.fromTextArray(
      headers: tableHeaders,
      data: List<List<dynamic>>.generate(
        data.items.length,
        (index) {
          final item = data.items[index];
          final total = item.unitPrice * item.quantity * (1 + item.taxRate);
          return [
            index + 1,
            item.description,
            item.quantity,
            '₹${item.unitPrice.toStringAsFixed(2)}',
            '${(item.taxRate * 100).toStringAsFixed(0)}%',
            '₹${total.toStringAsFixed(2)}',
          ];
        },
      ),
      headerStyle: pw.TextStyle(font: boldFont, color: PdfColors.white),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blue700),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
    );
  }

  static pw.Widget _buildTotals(InvoiceData data, pw.Font font, pw.Font boldFont) {
     final subtotal = data.items.map((item) => item.unitPrice * item.quantity).reduce((a, b) => a + b);
     final totalTax = data.items.map((item) => item.unitPrice * item.quantity * item.taxRate).reduce((a, b) => a + b);
     final grandTotal = subtotal + totalTax;

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildTotalRow('Subtotal', subtotal, font, boldFont),
                _buildTotalRow('Total Tax', totalTax, font, boldFont),
                pw.Divider(),
                _buildTotalRow('Grand Total', grandTotal, font, boldFont, isGrandTotal: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildTotalRow(String title, double value, pw.Font font, pw.Font boldFont, {bool isGrandTotal = false}){
    return pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(title, style: isGrandTotal ? pw.TextStyle(font: boldFont, fontSize: 12) : pw.TextStyle(font: font, fontSize: 10)),
              pw.Text('₹${value.toStringAsFixed(2)}', style: isGrandTotal ? pw.TextStyle(font: boldFont, fontSize: 12) : pw.TextStyle(font: font, fontSize: 10)),
            ],
          );
  }


  static pw.Widget _buildFooter(InvoiceData data, pw.Font font) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Divider(),
        pw.SizedBox(height: 10),
        pw.Text('Terms & Conditions', style: pw.TextStyle(font: font, fontWeight: pw.FontWeight.bold)),
        pw.Text("This is an electronically generated document.", style: pw.TextStyle(font: font)),
        pw.SizedBox(height: 20),
        pw.Text('Thank you for your business!', style: pw.TextStyle(font: font)),
      ],
    );
  }

  // --- Placeholder functions for other templates ---
  static Future<Uint8List> generateTallyInvoice(InvoiceData data) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text('Tally Invoice Template - Coming Soon!'));
    }));
    return pdf.save();
  }

  static Future<Uint8List> generateCleanInvoice(InvoiceData data) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text('Clean Invoice Template - Coming Soon!'));
    }));
    return pdf.save();
  }

  static Future<Uint8List> generateDetailedInvoice(InvoiceData data) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(child: pw.Text('Detailed Invoice Template - Coming Soon!'));
    }));
    return pdf.save();
  }
}