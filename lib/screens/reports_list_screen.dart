import 'package:flutter/material.dart';

class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildReportCategory(
            context,
            title: 'Transaction',
            reports: {
              'Sale Report': '/saleReport',
              'Purchase Report': '/purchaseReport',
              'Day Book': null,
              'All Transactions': null,
              'Bill Wise Profit': null,
              'Profit & Loss': null,
              'Cashflow': null,
              'Balance Sheet': null,
              'Trial Balance': null,
            },
          ),
          _buildReportCategory(
            context,
            title: 'Party reports',
            reports: {
              'Party Statement': null,
              'Party Wise Profit & Loss': null,
              'All Parties Report': null,
              'Party Report by Items': null,
              'Sale/Purchase by Party': null,
            },
          ),
          _buildReportCategory(
            context,
            title: 'GST reports',
            reports: {
              'GSTR-1': null,
              'GSTR-2': null,
              'GSTR-3B': null,
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportCategory(BuildContext context, {required String title, required Map<String, String?> reports}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ...reports.entries.map((entry) {
            return ListTile(
              title: Text(entry.key),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: entry.value != null
                  ? () {
                      Navigator.pushNamed(context, entry.value!);
                    }
                  : null, // Disable tap for reports with null routes
            );
          }).toList(),
        ],
      ),
    );
  }
}