// lib/screens/gst_transaction_report_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gst_transaction_report_model.dart';

class GstTransactionReportScreen extends StatefulWidget {
  const GstTransactionReportScreen({super.key});

  @override
  State<GstTransactionReportScreen> createState() =>
      _GstTransactionReportScreenState();
}

class _GstTransactionReportScreenState
    extends State<GstTransactionReportScreen> {
  late List<GstTransaction> transactions;

  @override
  void initState() {
    super.initState();
    transactions = _generateDummyData();
  }

  List<GstTransaction> _generateDummyData() {
    return [
      GstTransaction(
        date: DateTime(2025, 10, 6),
        type: GstTransactionType.sale,
        partyName: 'Test Buyer 1',
        gstType: 'B2B',
        invoiceNo: 'INV-1',
        taxableValue: 10169.49,
        igst: 1830.51,
        total: 12000,
      ),
      GstTransaction(
        date: DateTime(2025, 10, 7),
        type: GstTransactionType.sale,
        partyName: 'Test Buyer 2',
        gstType: 'B2B',
        invoiceNo: 'INV-2',
        taxableValue: 7203.39,
        cgst: 648.30,
        sgst: 648.30,
        total: 8500,
      ),
      GstTransaction(
        date: DateTime(2025, 10, 5),
        type: GstTransactionType.purchase,
        partyName: 'Test Supplier 1',
        gstType: 'B2B',
        invoiceNo: 'SUP-001',
        taxableValue: 5000,
        igst: 900,
        total: 5900,
      ),
      GstTransaction(
        date: DateTime(2025, 10, 8),
        type: GstTransactionType.purchase,
        partyName: 'Test Supplier 2',
        gstType: 'B2B',
        invoiceNo: 'SUP-002',
        taxableValue: 7000,
        cgst: 630,
        sgst: 630,
        total: 8260,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Transaction Report'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Transaction Type')),
            DataColumn(label: Text('Party Name')),
            DataColumn(label: Text('GST Type')),
            DataColumn(label: Text('Invoice No.')),
            DataColumn(label: Text('Taxable Value (₹)')),
            DataColumn(label: Text('IGST (₹)')),
            DataColumn(label: Text('CGST (₹)')),
            DataColumn(label: Text('SGST (₹)')),
            DataColumn(label: Text('Total (₹)')),
          ],
          rows: transactions.map((transaction) {
            return DataRow(cells: [
              DataCell(Text(DateFormat('dd-MM-yyyy').format(transaction.date))),
              DataCell(Text(transaction.type == GstTransactionType.sale
                  ? 'Sale'
                  : 'Purchase')),
              DataCell(Text(transaction.partyName)),
              DataCell(Text(transaction.gstType)),
              DataCell(Text(transaction.invoiceNo)),
              DataCell(Text(transaction.taxableValue.toStringAsFixed(2))),
              DataCell(Text(transaction.igst.toStringAsFixed(2))),
              DataCell(Text(transaction.cgst.toStringAsFixed(2))),
              DataCell(Text(transaction.sgst.toStringAsFixed(2))),
              DataCell(Text(transaction.total.toStringAsFixed(2))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}