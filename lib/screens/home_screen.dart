import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/feature_item_model.dart';
import '../widgets/greeting_header.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_item.dart';
import '../widgets/feature_grid_item.dart';
import 'add_sale_screen.dart'; 
import 'add_purchase_screen.dart'; // Import the new screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for recent transactions
    final List<Transaction> recentTransactions = [
      Transaction(name: 'John Doe', date: '4 Oct, 9:00 PM', amount: 5000, type: TransactionType.credit),
      Transaction(name: 'Jane Smith (Supplier)', date: '4 Oct, 7:30 PM', amount: 2500, type: TransactionType.debit),
      Transaction(name: 'Alice Johnson', date: '3 Oct, 11:00 AM', amount: 1200, type: TransactionType.credit),
    ];

    // Data for the feature grid
    final List<FeatureItemModel> features = [
      FeatureItemModel(icon: Icons.add_shopping_cart, title: 'Add Sale', color: Colors.orange),
      FeatureItemModel(icon: Icons.receipt_long, title: 'Add Purchase', color: Colors.blue),
      FeatureItemModel(icon: Icons.pie_chart, title: 'Reports', color: Colors.green),
      FeatureItemModel(icon: Icons.inventory, title: 'Inventory', color: Colors.purple),
      FeatureItemModel(icon: Icons.people, title: 'Customers', color: Colors.teal),
      FeatureItemModel(icon: Icons.swap_horiz, title: 'Transaction', color: Colors.redAccent),
      FeatureItemModel(icon: Icons.payment, title: 'Payment Settings', color: Colors.blueGrey),
      FeatureItemModel(icon: Icons.description, title: 'GSTR Filing', color: Colors.indigo),
      FeatureItemModel(icon: Icons.settings, title: 'Settings', color: Colors.grey.shade700),
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
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    final item = features[index];
                    return FeatureGridItem(
                      item: item,
                      onTap: () {
                        if (item.title == 'Add Sale') {
                          Navigator.pushNamed(context, '/addSale');
                        } else if (item.title == 'Add Purchase') {
                          Navigator.pushNamed(context, '/addPurchase');
                        }
                        // TODO: Handle other feature taps
                      },
                    );
                  },
                ),
                const SizedBox(height: 24),
                _buildRecentTransactions(context, recentTransactions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions(BuildContext context, List<Transaction> transactions) {
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
                // TODO: Navigate to all transactions screen
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