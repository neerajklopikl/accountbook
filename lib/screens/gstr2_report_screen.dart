// lib/screens/gstr2_report_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gstr2_models.dart';

class GSTR2ReportScreen extends StatefulWidget {
  const GSTR2ReportScreen({super.key});

  @override
  State<GSTR2ReportScreen> createState() => _GSTR2ReportScreenState();
}

class _GSTR2ReportScreenState extends State<GSTR2ReportScreen> {
  late GSTR2ReportData reportData;

  @override
  void initState() {
    super.initState();
    // In a real-world app, this data would be fetched from your purchase records
    // and auto-populated data from the GST portal.
    reportData = _generateDummyData();
  }

  GSTR2ReportData _generateDummyData() {
    return GSTR2ReportData(
      gstin: '09AABCU9603R1Z2',
      legalName: 'My Company',
      taxPeriod: 'October 2025',
      b2bPurchases: [
        B2BPurchase(
          supplierGstin: '27AAFCE1234F1Z5',
          invoiceNumber: 'SUP-001',
          invoiceDate: DateTime(2025, 10, 5),
          invoiceValue: 5900,
          taxableValue: 5000,
          igst: 900,
        ),
        B2BPurchase(
          supplierGstin: '29AABCD1234F1Z5',
          invoiceNumber: 'SUP-002',
          invoiceDate: DateTime(2025, 10, 8),
          invoiceValue: 8260,
          taxableValue: 7000,
          cgst: 630,
          sgst: 630,
        ),
      ],
      creditDebitNotes: [
        PurchaseCreditDebitNote(
          supplierGstin: '27AAFCE1234F1Z5',
          noteNumber: 'DN-01',
          noteDate: DateTime(2025, 10, 10),
          noteValue: 590,
          taxableValue: 500,
          igst: 90,
        )
      ],
      hsnSummary: [
        HSNInwardSummary(
          hsn: '3926',
          description: 'Plastic Goods',
          uqc: 'PCS',
          totalQuantity: 100,
          taxableValue: 5000,
          igst: 900,
        ),
        HSNInwardSummary(
          hsn: '8471',
          description: 'Computer Parts',
          uqc: 'NOS',
          totalQuantity: 20,
          taxableValue: 7000,
          cgst: 630,
          sgst: 630,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSTR-2 Report'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.sync)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildB2BSection(reportData.b2bPurchases),
            _buildCreditDebitNoteSection(reportData.creditDebitNotes),
            _buildHsnSection(reportData.hsnSummary),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GSTR-2: Inward Supplies for ${reportData.taxPeriod}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 20),
            _buildHeaderRow('GSTIN:', reportData.gstin),
            const SizedBox(height: 8),
            _buildHeaderRow('Legal Name:', reportData.legalName),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSection(
      {required String title,
      required List<DataColumn> columns,
      required List<DataRow> rows}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns,
              rows: rows,
              columnSpacing: 20,
              headingRowColor:
                  MaterialStateProperty.all(Colors.blue.shade50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildB2BSection(List<B2BPurchase> purchases) {
    return _buildSection(
      title: '3. Inward supplies from registered persons',
      columns: const [
        DataColumn(label: Text('Supplier\nGSTIN')),
        DataColumn(label: Text('Invoice\nNumber')),
        DataColumn(label: Text('Invoice\nDate')),
        DataColumn(label: Text('Invoice\nValue (₹)')),
        DataColumn(label: Text('Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
      ],
      rows: purchases.map((purchase) {
        return DataRow(cells: [
          DataCell(Text(purchase.supplierGstin)),
          DataCell(Text(purchase.invoiceNumber)),
          DataCell(Text(DateFormat('dd-MM-yyyy').format(purchase.invoiceDate))),
          DataCell(Text(purchase.invoiceValue.toStringAsFixed(2))),
          DataCell(Text(purchase.taxableValue.toStringAsFixed(2))),
          DataCell(Text(purchase.igst.toStringAsFixed(2))),
          DataCell(Text(purchase.cgst.toStringAsFixed(2))),
          DataCell(Text(purchase.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }

  Widget _buildCreditDebitNoteSection(List<PurchaseCreditDebitNote> notes) {
    return _buildSection(
      title: '6. Credit/Debit Notes received',
      columns: const [
        DataColumn(label: Text('Supplier\nGSTIN')),
        DataColumn(label: Text('Note\nNumber')),
        DataColumn(label: Text('Note\nDate')),
        DataColumn(label: Text('Note\nValue (₹)')),
        DataColumn(label: Text('Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
      ],
      rows: notes.map((note) {
        return DataRow(cells: [
          DataCell(Text(note.supplierGstin)),
          DataCell(Text(note.noteNumber)),
          DataCell(Text(DateFormat('dd-MM-yyyy').format(note.noteDate))),
          DataCell(Text(note.noteValue.toStringAsFixed(2))),
          DataCell(Text(note.taxableValue.toStringAsFixed(2))),
          DataCell(Text(note.igst.toStringAsFixed(2))),
          DataCell(Text(note.cgst.toStringAsFixed(2))),
          DataCell(Text(note.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }

  Widget _buildHsnSection(List<HSNInwardSummary> summaries) {
    return _buildSection(
      title: '13. HSN summary of inward supplies',
      columns: const [
        DataColumn(label: Text('HSN')),
        DataColumn(label: Text('Description')),
        DataColumn(label: Text('UQC')),
        DataColumn(label: Text('Total Qty')),
        DataColumn(label: Text('Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
      ],
      rows: summaries.map((summary) {
        return DataRow(cells: [
          DataCell(Text(summary.hsn)),
          DataCell(Text(summary.description)),
          DataCell(Text(summary.uqc)),
          DataCell(Text(summary.totalQuantity.toStringAsFixed(2))),
          DataCell(Text(summary.taxableValue.toStringAsFixed(2))),
          DataCell(Text(summary.igst.toStringAsFixed(2))),
          DataCell(Text(summary.cgst.toStringAsFixed(2))),
          DataCell(Text(summary.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }
}