// lib/screens/gstr9_report_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gstr9_models.dart';

class GSTR9ReportScreen extends StatefulWidget {
  const GSTR9ReportScreen({super.key});

  @override
  State<GSTR9ReportScreen> createState() => _GSTR9ReportScreenState();
}

class _GSTR9ReportScreenState extends State<GSTR9ReportScreen> {
  late GSTR9ReportData reportData;

  @override
  void initState() {
    super.initState();
    reportData = _generateDummyData();
  }

  GSTR9ReportData _generateDummyData() {
    return GSTR9ReportData(
      gstin: '09AABCU9603R1Z2',
      legalName: 'My Company',
      taxPeriod: '2024-25',
      aggregateTurnover: 150230.50,
      outwardSupplies: OutwardSupplies(
        b2cTaxableValue: 8034533.99,
        b2cIntegratedTax: 0.00,
        b2bTaxableValue: 8512892.26,
        b2bIntegratedTax: 305379.75,
      ),
      inwardSupplies: InwardSupplies(
        reverseChargeTaxableValue: 1512.00,
        reverseChargeIntegratedTax: 36.50,
      ),
      itcDetails: ITCDetails(
        itcAsPerGSTR3B: 12345.67,
        itcAsPerGSTR2A: 12000.00,
        itcClaimed: 12000.00,
      ),
      taxPaidDetails: TaxPaidDetails(
        integratedTax: 346274.41,
        centralTax: 1324061.72,
        stateTax: 1324061.72,
        cess: 0.00,
        interest: 0.00,
        lateFee: 0.00,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GSTR-9 Annual Return'),
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
            _buildOutwardInwardSuppliesSection(),
            _buildITCSection(),
            _buildTaxPaidSection(),
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
            Text('GSTR-9 Summary for FY ${reportData.taxPeriod}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 20),
            _buildHeaderRow('GSTIN:', reportData.gstin),
            const SizedBox(height: 8),
            _buildHeaderRow('Legal Name:', reportData.legalName),
            const SizedBox(height: 8),
            _buildHeaderRow('Aggregate Turnover:',
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

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        children: children,
      ),
    );
  }

  Widget _buildOutwardInwardSuppliesSection() {
    return _buildSection(
      title: 'Pt. II: Details of Outward and Inward Supplies',
      children: [
        _buildDataTable(
          columns: const [
            DataColumn(label: Text('Nature of Supplies')),
            DataColumn(label: Text('Taxable Value (₹)')),
            DataColumn(label: Text('Integrated Tax (₹)')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('Supplies to un-registered persons (B2C)')),
              DataCell(Text(reportData.outwardSupplies.b2cTaxableValue.toStringAsFixed(2))),
              DataCell(Text(reportData.outwardSupplies.b2cIntegratedTax.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Supplies to registered persons (B2B)')),
              DataCell(Text(reportData.outwardSupplies.b2bTaxableValue.toStringAsFixed(2))),
              DataCell(Text(reportData.outwardSupplies.b2bIntegratedTax.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Inward supplies (Reverse Charge)')),
              DataCell(Text(reportData.inwardSupplies.reverseChargeTaxableValue.toStringAsFixed(2))),
              DataCell(Text(reportData.inwardSupplies.reverseChargeIntegratedTax.toStringAsFixed(2))),
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildITCSection() {
    return _buildSection(
      title: 'Pt. III: Details of ITC for the Financial Year',
      children: [
        _buildDataTable(
          columns: const [
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Amount (₹)')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('ITC as per GSTR-3B')),
              DataCell(Text(reportData.itcDetails.itcAsPerGSTR3B.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('ITC as per GSTR-2A')),
              DataCell(Text(reportData.itcDetails.itcAsPerGSTR2A.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('ITC Claimed')),
              DataCell(Text(reportData.itcDetails.itcClaimed.toStringAsFixed(2))),
            ]),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxPaidSection() {
    return _buildSection(
      title: 'Pt. IV: Details of Tax Paid',
      children: [
        _buildDataTable(
          columns: const [
            DataColumn(label: Text('Tax Head')),
            DataColumn(label: Text('Amount (₹)')),
          ],
          rows: [
            DataRow(cells: [
              const DataCell(Text('Integrated Tax')),
              DataCell(Text(reportData.taxPaidDetails.integratedTax.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Central Tax')),
              DataCell(Text(reportData.taxPaidDetails.centralTax.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('State/UT Tax')),
              DataCell(Text(reportData.taxPaidDetails.stateTax.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Cess')),
              DataCell(Text(reportData.taxPaidDetails.cess.toStringAsFixed(2))),
            ]),
            DataRow(cells: [
              const DataCell(Text('Interest')),
              DataCell(Text(reportData.taxPaidDetails.interest.toStringAsFixed(2))),
            ]),
             DataRow(cells: [
              const DataCell(Text('Late Fee')),
              DataCell(Text(reportData.taxPaidDetails.lateFee.toStringAsFixed(2))),
            ]),
          ],
        ),
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
}