import 'package:flutter/material.dart';
import '../widgets/premium_feature_dialog.dart';

class ReportsListScreen extends StatelessWidget {
  const ReportsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the main content widget containing the list of reports.
    // We define it once to avoid repeating code.
    Widget reportListView = ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical padding
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
            'GSTR-1': '/gstr1Report',
            'GSTR-2': '/gstr2Report',
            'GSTR-3B': '/gstr3bReport',
            'GST Transaction report': '/gstTransactionReport',
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
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      // FIX: Use a LayoutBuilder to create a responsive UI that centers on desktop.
      body: LayoutBuilder(
        builder: (context, constraints) {
          // If the screen is wide (e.g., a desktop or tablet in landscape),
          // center the content and give it a maximum width for better readability.
          if (constraints.maxWidth > 700) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700), // Max width for desktop
                child: reportListView,
              ),
            );
          } else {
            // On smaller screens (mobile), let the list take the full width.
            return reportListView;
          }
        },
      ),
    );
  }

  Widget _buildReportCategory(BuildContext context,
      {required String title, required Map<String, String?> reports}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          const Divider(height: 1),
          ...reports.entries.map((entry) {
            bool isPremium = entry.key.contains('Bill Wise Profit') ||
                entry.key.contains('Balance Sheet');
                
            return ListTile(
              title: Text(entry.key),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isPremium)
                    const Icon(Icons.lock, size: 16, color: Colors.amber),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                ],
              ),
              onTap: entry.value != null
                  ? () {
                      if (isPremium) {
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

