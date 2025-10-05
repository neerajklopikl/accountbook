// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/feature_item_model.dart';
import '../widgets/greeting_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_item.dart';
import '../widgets/feature_grid_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for recent transactions
    final List<Transaction> recentTransactions = [
      Transaction(
          name: 'John Doe',
          date: '4 Oct, 9:00 PM',
          amount: 5000,
          type: TransactionType.credit),
      Transaction(
          name: 'Jane Smith (Supplier)',
          date: '4 Oct, 7:30 PM',
          amount: 2500,
          type: TransactionType.debit),
      Transaction(
          name: 'Alice Johnson',
          date: '3 Oct, 11:00 AM',
          amount: 1200,
          type: TransactionType.credit),
    ];

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GreetingHeader(userName: 'User'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BalanceCard(balance: '1,25,000.00'),
                const SizedBox(height: 24),
                _buildQuickLinks(context),
                const SizedBox(height: 24),
                _buildRecentTransactions(context, recentTransactions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildQuickLinkItem(
                context, Icons.add_box_outlined, 'Add Txn', () => _showAddTransactionSheet(context)),
            _buildQuickLinkItem(
                context, Icons.receipt_long_outlined, 'Sale Report', () => Navigator.pushNamed(context, '/saleReport')),
            _buildQuickLinkItem(
                context, Icons.settings_outlined, 'Txn Settings', () => Navigator.pushNamed(context, '/txnSettings')),
            _buildQuickLinkItem(
                context, Icons.more_horiz, 'Show All', () => _showMoreOptionsSheet(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinkItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 28),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

   void _showAddTransactionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final saleItems = [
          FeatureItemModel(icon: Icons.download, title: 'Payment-In', color: Colors.green),
          FeatureItemModel(icon: Icons.undo, title: 'Sale Return', color: Colors.orange),
          FeatureItemModel(icon: Icons.local_shipping, title: 'Delivery Challan', color: Colors.blue),
          FeatureItemModel(icon: Icons.request_quote, title: 'Estimate/Quot..', color: Colors.purple),
          FeatureItemModel(icon: Icons.list_alt, title: 'Sale Order', color: Colors.teal),
          FeatureItemModel(icon: Icons.receipt, title: 'Sale Invoice', color: Colors.red),
        ];

        final purchaseItems = [
          FeatureItemModel(icon: Icons.shopping_cart, title: 'Purchase', color: Colors.blue),
          FeatureItemModel(icon: Icons.upload, title: 'Payment-Out', color: Colors.red),
          FeatureItemModel(icon: Icons.assignment_return, title: 'Purchase Return', color: Colors.orange),
          FeatureItemModel(icon: Icons.event_note, title: 'Purchase Order', color: Colors.teal),
        ];

        final otherItems = [
          FeatureItemModel(icon: Icons.money_off, title: 'Expense', color: Colors.redAccent),
          FeatureItemModel(icon: Icons.attach_money, title: 'Other Income', color: Colors.green),
        ];

        final routes = {
          'Payment-In': '/paymentIn',
          'Sale Return': '/saleReturn',
          'Delivery Challan': '/deliveryChallan',
          'Estimate/Quot..': '/estimateQuote',
          'Sale Order': '/saleOrder',
          'Sale Invoice': '/saleInvoice',
          'Purchase': '/addPurchase',
          'Payment-Out': '/paymentOut',
          'Purchase Return': '/purchaseReturn',
          'Purchase Order': '/purchaseOrder',
          'Expense': '/expense',
          'Other Income': '/otherIncome',
        };

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTransactionTypeSection(context, 'Sale Transactions', saleItems, routes),
                _buildTransactionTypeSection(context, 'Purchase Transactions', purchaseItems, routes),
                _buildTransactionTypeSection(context, 'Other Transactions', otherItems, routes),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTransactionTypeSection(BuildContext context, String title, List<FeatureItemModel> items, Map<String, String> routes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return FeatureGridItem(
              item: item,
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                final route = routes[item.title];
                if (route != null) {
                  Navigator.pushNamed(context, route);
                }
              },
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

   void _showMoreOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
         final moreOptions = [
            FeatureItemModel(icon: Icons.account_balance, title: 'Bank Accounts', color: Colors.blue),
            FeatureItemModel(icon: Icons.book, title: 'Day Book', color: Colors.orange),
            FeatureItemModel(icon: Icons.receipt_long, title: 'All Txns Report', color: Colors.green),
            FeatureItemModel(icon: Icons.trending_up, title: 'Profit & Loss', color: Colors.purple),
            FeatureItemModel(icon: Icons.account_balance_wallet, title: 'Balance Sheet', color: Colors.teal),
            FeatureItemModel(icon: Icons.paid, title: 'Billwise PNL', color: Colors.redAccent),
        ];
        final routes = {
          'Day Book': '/dayBook',
          'All Txns Report': '/allTransactions',
          'Profit & Loss': '/profitLoss',
          'Balance Sheet': '/balanceSheet',
          'Billwise PNL': '/billWiseProfit',
        };

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.6,
          minChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                 children: [
                  // Handle
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('More Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      controller: scrollController,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: moreOptions.length,
                      itemBuilder: (context, index) {
                        final item = moreOptions[index];
                        return FeatureGridItem(
                          item: item,
                          onTap: () {
                             Navigator.pop(context); // Close the bottom sheet
                             final route = routes[item.title];
                             if (route != null) {
                               Navigator.pushNamed(context, route);
                             }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRecentTransactions(
      BuildContext context, List<Transaction> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/allTransactions');
              },
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...transactions.map((tx) => TransactionItem(transaction: tx)).toList(),
      ],
    );
  }
}