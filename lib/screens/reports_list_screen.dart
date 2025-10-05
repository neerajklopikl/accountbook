import 'package:flutter/material.dart';
import '../widgets/premium_feature_dialog.dart';

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
              'Day Book': '/dayBook',
              'All Transactions': '/allTransactions',
              'Bill Wise Profit': '/billWiseProfit',
              'Profit & Loss': '/profitLoss',
              'Cashflow': '/cashflow',
              'Balance Sheet': '/balanceSheet',
              'Trial Balance': '/trialBalance',
            },
          ),
          _buildReportCategory(
            context,
            title: 'Party reports',
            reports: {
              'Party Statement': '/partyReports',
              'Party Wise Profit & Loss': '/partyReports',
              'All Parties Report': '/partyReports',
              'Party Report by Items': '/partyReports',
              'Sale/Purchase by Party': '/partyReports',
            },
          ),
          _buildReportCategory(
            context,
            title: 'GST reports',
            reports: {
              'GSTR-1': '/gstReports',
              'GSTR-2': '/gstReports',
              'GSTR-3B': '/gstReports',
              'GST Transaction report': '/gstReports',
              'GSTR-9': '/gstReports',
              'Sale Summary by HSN': '/gstReports',
              'SAC Report': '/gstReports',
            },
          ),
          _buildReportCategory(
            context,
            title: 'Item/Stock reports',
            reports: {
              'Stock Summary Report': '/stockReports',
              'Item Report by Party': '/stockReports',
              'Item Wise Profit & Loss': '/stockReports',
              'Low Stock Summary Report': '/stockReports',
              'Item Detail Report': '/stockReports',
              'Sale/Purchase By Item Category': '/stockReports',
              'Stock summary By Item Category': '/stockReports',
              'Item Batch Report': '/stockReports',
              'Item Serial Report': '/stockReports',
              'Item Wise Discount': '/stockReports',
            },
          ),
          _buildReportCategory(
            context,
            title: 'Business status',
            reports: {
              'Bank Statement': null,
              'Discount Report': null,
            },
          ),
          _buildReportCategory(
            context,
            title: 'Taxes',
            reports: {
              'GST Report': null,
              'GST Rate Report': null,
              'Form No. 27EQ': null,
              'TCS Receivable': null,
              'TDS Payable': null,
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportCategory(BuildContext context,
      {required String title, required Map<String, String?> reports}) {
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (entry.key.contains('Bill Wise Profit') ||
                      entry.key.contains('Balance Sheet'))
                    const Icon(Icons.lock, size: 16, color: Colors.amber),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              onTap: entry.value != null
                  ? () {
                      if (entry.key.contains('Bill Wise Profit') ||
                          entry.key.contains('Balance Sheet')) {
                        showDialog(
                            context: context,
                            builder: (context) => const PremiumFeatureDialog());
                      } else {
                        Navigator.pushNamed(context, entry.value!);
                      }
                    }
                  : null,
            );
          }).toList(),
        ],
      ),
    );
  }
}