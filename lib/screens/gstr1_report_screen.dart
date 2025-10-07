import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gstr1_models.dart';

class GSTR1ReportScreen extends StatefulWidget {
  const GSTR1ReportScreen({super.key});

  @override
  State<GSTR1ReportScreen> createState() => _GSTR1ReportScreenState();
}

class _GSTR1ReportScreenState extends State<GSTR1ReportScreen> {
  late GSTR1ReportData reportData;

  @override
  void initState() {
    super.initState();
    // In a real application, you would fetch this data from your database/API
    // based on the selected tax period.
    reportData = _generateDummyData();
  }

  // This function creates sample data for demonstration purposes.
  GSTR1ReportData _generateDummyData() {
    return GSTR1ReportData(
      gstin: '09AABCU9603R1Z2',
      legalName: 'My Company',
      aggregateTurnover: 150230.50,
      taxPeriod: 'October 2025',
      b2bInvoices: [
        B2BInvoice(
            invoiceNumber: 'INV-1',
            invoiceDate: DateTime(2025, 10, 6),
            recipientGstin: '27AAFCE1234F1Z5',
            recipientName: 'Test Buyer 1',
            invoiceValue: 12000,
            taxableValue: 10169.49,
            igst: 1830.51),
        B2BInvoice(
            invoiceNumber: 'INV-2',
            invoiceDate: DateTime(2025, 10, 7),
            recipientGstin: '29AABCD1234F1Z5',
            recipientName: 'Test Buyer 2',
            invoiceValue: 8500,
            taxableValue: 7203.39,
            cgst: 648.30,
            sgst: 648.30),
      ],
      b2cSmallSummary: [
        B2CSummary(
            placeOfSupply: 'Uttar Pradesh',
            taxableValue: 5500,
            cgst: 495,
            sgst: 495),
        B2CSummary(
            placeOfSupply: 'Delhi', taxableValue: 3000, igst: 540),
      ],
      creditDebitNotesRegistered: [
        CreditDebitNote(
            noteNumber: 'CN-1',
            noteDate: DateTime(2025, 10, 8),
            originalInvoiceNumber: 'INV-1',
            originalInvoiceDate: DateTime(2025, 10, 6),
            noteValue: 1180,
            taxableValue: 1000,
            igst: 180),
      ],
      hsnSummary: [
        HSNSummary(
            hsn: '8517',
            description: 'Mobile Phones',
            uqc: 'NOS',
            totalQuantity: 15,
            totalValue: 18500,
            taxableValue: 15677.97,
            igst: 2370.51,
            cgst: 1143.3,
            sgst: 1143.3),
         HSNSummary(
            hsn: '9983',
            description: 'Other professional, technical and business services',
            uqc: 'OTH',
            totalQuantity: 0,
            totalValue: 2000,
            taxableValue: 1694.92,
            cgst: 152.55,
            sgst: 152.55),
      ],
      documentSummary: DocumentSummary(
        invoicesForOutwardSupply: 2,
        creditNotes: 1,
        debitNotes: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSTR-1 Report'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
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
            _buildB2BSection(reportData.b2bInvoices),
            _buildB2CSection(reportData.b2cSmallSummary),
            _buildCreditDebitNoteSection(reportData.creditDebitNotesRegistered),
            _buildHsnSection(reportData.hsnSummary),
            _buildDocumentSummarySection(reportData.documentSummary),
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
            Text('GSTR-1 Summary for ${reportData.taxPeriod}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 20),
            _buildHeaderRow('GSTIN:', reportData.gstin),
            const SizedBox(height: 8),
            _buildHeaderRow('Legal Name:', reportData.legalName),
            const SizedBox(height: 8),
            _buildHeaderRow('Aggregate Turnover (Prev. FY):',
                '₹ ${NumberFormat.decimalPattern('en_IN').format(reportData.aggregateTurnover)}'),
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

  Widget _buildB2BSection(List<B2BInvoice> invoices) {
    return _buildSection(
      title: '4. B2B Supplies',
      columns: const [
        DataColumn(label: Text('Invoice\nNumber')),
        DataColumn(label: Text('Invoice\nDate')),
        DataColumn(label: Text('Recipient\nGSTIN')),
        DataColumn(label: Text('Invoice\nValue (₹)')),
        DataColumn(label: Text('Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
      ],
      rows: invoices.map((invoice) {
        return DataRow(cells: [
          DataCell(Text(invoice.invoiceNumber)),
          DataCell(Text(DateFormat('dd-MM-yyyy').format(invoice.invoiceDate))),
          DataCell(Text(invoice.recipientGstin)),
          DataCell(Text(invoice.invoiceValue.toStringAsFixed(2))),
          DataCell(Text(invoice.taxableValue.toStringAsFixed(2))),
          DataCell(Text(invoice.igst.toStringAsFixed(2))),
          DataCell(Text(invoice.cgst.toStringAsFixed(2))),
          DataCell(Text(invoice.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }

    Widget _buildB2CSection(List<B2CSummary> summaries) {
    return _buildSection(
      title: '7. B2C (Others) Supplies',
      columns: const [
        DataColumn(label: Text('Place of Supply')),
        DataColumn(label: Text('Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
      ],
      rows: summaries.map((summary) {
        return DataRow(cells: [
          DataCell(Text(summary.placeOfSupply)),
          DataCell(Text(summary.taxableValue.toStringAsFixed(2))),
          DataCell(Text(summary.igst.toStringAsFixed(2))),
          DataCell(Text(summary.cgst.toStringAsFixed(2))),
          DataCell(Text(summary.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }

   Widget _buildCreditDebitNoteSection(List<CreditDebitNote> notes) {
    return _buildSection(
      title: '9B. Credit/Debit Notes (Registered)',
      columns: const [
        DataColumn(label: Text('Note\nNumber')),
        DataColumn(label: Text('Note\nDate')),
        DataColumn(label: Text('Original Inv.\nNumber')),
        DataColumn(label: Text('Original Inv.\nDate')),
        DataColumn(label: Text('Note\nValue (₹)')),
        DataColumn(label: Text('Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
      ],
      rows: notes.map((note) {
        return DataRow(cells: [
          DataCell(Text(note.noteNumber)),
          DataCell(Text(DateFormat('dd-MM-yyyy').format(note.noteDate))),
          DataCell(Text(note.originalInvoiceNumber)),
          DataCell(Text(DateFormat('dd-MM-yyyy').format(note.originalInvoiceDate))),
          DataCell(Text(note.noteValue.toStringAsFixed(2))),
          DataCell(Text(note.taxableValue.toStringAsFixed(2))),
          DataCell(Text(note.igst.toStringAsFixed(2))),
          DataCell(Text(note.cgst.toStringAsFixed(2))),
          DataCell(Text(note.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }

    Widget _buildHsnSection(List<HSNSummary> summaries) {
    return _buildSection(
      title: '12. HSN-wise Summary of Outward Supplies',
      columns: const [
        DataColumn(label: Text('HSN')),
        DataColumn(label: Text('Description')),
        DataColumn(label: Text('UQC')),
        DataColumn(label: Text('Total Qty')),
        DataColumn(label: Text('Total\nValue (₹)')),
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
          DataCell(Text(summary.totalQuantity == 0 ? '-' : summary.totalQuantity.toStringAsFixed(2))),
          DataCell(Text(summary.totalValue.toStringAsFixed(2))),
          DataCell(Text(summary.taxableValue.toStringAsFixed(2))),
          DataCell(Text(summary.igst.toStringAsFixed(2))),
          DataCell(Text(summary.cgst.toStringAsFixed(2))),
          DataCell(Text(summary.sgst.toStringAsFixed(2))),
        ]);
      }).toList(),
    );
  }

   Widget _buildDocumentSummarySection(DocumentSummary summary) {
    return Card(
       clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: const Text('13. Documents Issued', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        children: [
           ListTile(
            title: const Text('Invoices for outward supply'),
            trailing: Text(summary.invoicesForOutwardSupply.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('Credit Notes'),
             trailing: Text(summary.creditNotes.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: const Text('Debit Notes'),
             trailing: Text(summary.debitNotes.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
