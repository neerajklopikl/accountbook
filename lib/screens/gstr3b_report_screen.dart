// lib/screens/gstr3b_report_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gstr3b_models.dart';

class GSTR3BReportScreen extends StatefulWidget {
  const GSTR3BReportScreen({super.key});

  @override
  State<GSTR3BReportScreen> createState() => _GSTR3BReportScreenState();
}

class _GSTR3BReportScreenState extends State<GSTR3BReportScreen> {
  late GSTR3BReportData reportData;

  @override
  void initState() {
    super.initState();
    // In a real app, this data would be calculated from sales, purchases,
    // and other transactions recorded during the tax period.
    reportData = _generateDummyData();
  }

  GSTR3BReportData _generateDummyData() {
    return GSTR3BReportData(
      gstin: '09AABCU9603R1Z2',
      legalName: 'My Company',
      taxPeriod: 'October 2025',
      outwardInwardSupplies: OutwardInwardSupplies(
        taxableValue: 22372.88,
        igst: 2370.51,
        cgst: 1143.3,
        sgst: 1143.3,
      ),
      interStateSupplies: InterStateSupplies(
        placeOfSupply: 'Delhi',
        totalTaxableValue: 3000,
        amountOfIntegratedTax: 540,
      ),
      eligibleITC: EligibleITC(
        igst: 900,
        cgst: 630,
        sgst: 630,
      ),
      lateFeeInterest: LateFeeInterest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSTR-3B Report'),
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
            _buildOutwardSuppliesSection(reportData.outwardInwardSupplies),
            _buildInterStateSuppliesSection(reportData.interStateSupplies),
            _buildEligibleITCSection(reportData.eligibleITC),
            _buildLateFeeInterestSection(reportData.lateFeeInterest),
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
            Text('GSTR-3B Summary for ${reportData.taxPeriod}',
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

  Widget _buildDataTable(
      {required List<DataColumn> columns, required List<DataRow> rows}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns,
        rows: rows,
        columnSpacing: 20,
        headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
      ),
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
        children: [_buildDataTable(columns: columns, rows: rows)],
      ),
    );
  }

  Widget _buildOutwardSuppliesSection(OutwardInwardSupplies data) {
    return _buildSection(
      title: '3.1 Outward & Inward Supplies Liable to Reverse Charge',
      columns: const [
        DataColumn(label: Text('Nature of Supplies')),
        DataColumn(label: Text('Total Taxable\nValue (₹)')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
        DataColumn(label: Text('CESS (₹)')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text(
              'Outward taxable supplies\n(other than zero rated, nil rated and exempted)')),
          DataCell(Text(data.taxableValue.toStringAsFixed(2))),
          DataCell(Text(data.igst.toStringAsFixed(2))),
          DataCell(Text(data.cgst.toStringAsFixed(2))),
          DataCell(Text(data.sgst.toStringAsFixed(2))),
          DataCell(Text(data.cess.toStringAsFixed(2))),
        ]),
      ],
    );
  }

  Widget _buildInterStateSuppliesSection(InterStateSupplies data) {
    return _buildSection(
      title: '3.2 Inter-State Supplies to Unregistered Persons',
      columns: const [
        DataColumn(label: Text('Place of Supply (State/UT)')),
        DataColumn(label: Text('Total Taxable\nValue (₹)')),
        DataColumn(label: Text('Amount of Integrated\nTax (₹)')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text(data.placeOfSupply)),
          DataCell(Text(data.totalTaxableValue.toStringAsFixed(2))),
          DataCell(Text(data.amountOfIntegratedTax.toStringAsFixed(2))),
        ]),
      ],
    );
  }

  Widget _buildEligibleITCSection(EligibleITC data) {
    return _buildSection(
      title: '4. Eligible ITC',
      columns: const [
        DataColumn(label: Text('Details')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
        DataColumn(label: Text('CESS (₹)')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('All other ITC')),
          DataCell(Text(data.igst.toStringAsFixed(2))),
          DataCell(Text(data.cgst.toStringAsFixed(2))),
          DataCell(Text(data.sgst.toStringAsFixed(2))),
          DataCell(Text(data.cess.toStringAsFixed(2))),
        ]),
      ],
    );
  }

  Widget _buildLateFeeInterestSection(LateFeeInterest data) {
    return _buildSection(
      title: '5.1 Interest & Late Fee',
      columns: const [
        DataColumn(label: Text('Description')),
        DataColumn(label: Text('IGST (₹)')),
        DataColumn(label: Text('CGST (₹)')),
        DataColumn(label: Text('SGST (₹)')),
        DataColumn(label: Text('CESS (₹)')),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('Interest')),
          DataCell(Text(data.igst.toStringAsFixed(2))),
          DataCell(Text(data.cgst.toStringAsFixed(2))),
          DataCell(Text(data.sgst.toStringAsFixed(2))),
          DataCell(Text(data.cess.toStringAsFixed(2))),
        ]),
      ],
    );
  }
}