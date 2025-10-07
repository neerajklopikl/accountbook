// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
// NEW: Importing widgets to use in the new design
import '../widgets/greeting_header.dart';
import '../widgets/balance_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAllDocuments = false;

  void _showSetupSheet(BuildContext context, {required String type}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('One-time setup',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Text(
              'Link your $type account with AccountBook',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Placeholder for the graphic shown in the video
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.business, size: 40, color: Colors.blue),
                Text('  <--->  '),
                Icon(Icons.receipt_long, size: 40, color: Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the bottom sheet
                if (type == 'E-invoice') {
                  Navigator.pushNamed(context, '/eInvoiceLogin');
                } else if (type == 'E-Waybill') {
                  Navigator.pushNamed(context, '/eWayBillLogin');
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text('Setup Now'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // UPDATED: Restructured the data for the new layout
    final primaryActions = [
      FeatureItemModel(
          icon: Icons.receipt_long_outlined,
          title: 'Invoices',
          color: Colors.blue.shade700,
          route: '/saleInvoice'),
      FeatureItemModel(
          icon: Icons.request_quote_outlined,
          title: 'Quotation',
          color: Colors.orange.shade700,
          route: '/quotationList'),
      FeatureItemModel(
          icon: Icons.shopping_cart_outlined,
          title: 'Purchase',
          color: Colors.green.shade700,
          route: '/createPurchase'),
    ];

    final otherDocuments = [
      FeatureItemModel(
        icon: Icons.receipt_long,
        title: 'e-Invoice',
        color: Colors.purple,
        onTap: () => _showSetupSheet(context, type: 'E-invoice'),
      ),
      FeatureItemModel(
        icon: Icons.local_shipping,
        title: 'e-Way Bills',
        color: Colors.blue,
        onTap: () => _showSetupSheet(context, type: 'E-Waybill'),
      ),
      FeatureItemModel(
          icon: Icons.description,
          title: 'Proforma Invoices',
          color: Colors.teal,
          route: '/quotationList'),
      FeatureItemModel(
          icon: Icons.payment,
          title: 'Payment Receipts',
          color: Colors.redAccent,
          route: '/paymentReceiptList'),
      FeatureItemModel(
          icon: Icons.money_off,
          title: 'Payments Made',
          color: Colors.red,
          route: '/paymentsMadeList'), // FIX: Added route for navigation
      FeatureItemModel(
          icon: Icons.request_page,
          title: 'Debit Notes',
          color: Colors.green,
          route: '/debitNoteList'), // FIX: Added route for navigation
      // MODIFIED: Navigates to the new Credit Note list screen
      FeatureItemModel(
          icon: Icons.credit_score,
          title: 'Credit Notes',
          color: Colors.blue,
          route: '/creditNoteList'),
      // MODIFIED: Navigates to the new Digital Signature setup screen
      FeatureItemModel(
          icon: Icons.badge,
          title: 'Digital Signature',
          color: Colors.green,
          route: '/setupDigitalSignature'),
      FeatureItemModel(
          icon: Icons.account_balance,
          title: 'Bank Statements',
          color: Colors.indigo),
      FeatureItemModel(
          icon: Icons.request_quote,
          title: 'Expense Vouchers',
          color: Colors.deepOrange),
      FeatureItemModel(
          icon: Icons.book, title: 'Journal Vouchers', color: Colors.brown),
      FeatureItemModel(
          icon: Icons.inventory,
          title: 'Stock Journals',
          color: Colors.blueGrey),
      FeatureItemModel(
          icon: Icons.receipt,
          title: 'Goods Receipt Note',
          color: Colors.cyan),
    ];

    final moreOptions = [
      FeatureItemModel(
          icon: Icons.card_giftcard,
          title: 'Festive Greetings',
          color: Colors.green),
      FeatureItemModel(
          icon: Icons.find_in_page,
          title: 'HSN/SAC Finder',
          color: Colors.red),
      FeatureItemModel(
          icon: Icons.qr_code_scanner,
          title: 'E-Invoice QR Scanner',
          color: Colors.blue),
      FeatureItemModel(
          icon: Icons.add_shopping_cart,
          title: 'Purchase stock',
          color: Colors.blueAccent),
      FeatureItemModel(icon: Icons.sell, title: 'Sold stock', color: Colors.orange),
      FeatureItemModel(
          icon: Icons.upload_file,
          title: 'GST Filing',
          color: Colors.deepPurple),
      FeatureItemModel(icon: Icons.attach_money, title: 'TDS/TCS', color: Colors.teal),
      FeatureItemModel(
          icon: Icons.sync_alt,
          title: 'Bank Reconciliation',
          color: Colors.lightBlue),
      // NEW: Added Delivery Challan next to Budgeting
      FeatureItemModel(
          icon: Icons.local_shipping,
          title: 'Delivery Challan',
          color: Colors.brown,
          route: '/deliveryChallan'),
      FeatureItemModel(icon: Icons.pie_chart, title: 'Budgeting', color: Colors.pink),
      FeatureItemModel(
          icon: Icons.list_alt,
          title: 'All Tx Report',
          color: Colors.grey,
          route: '/allTxReport'),
    ];

    return Scaffold(
      // UPDATED: Complete redesign using a ListView for a cleaner, more organized look.
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          // NEW: Added Greeting and Balance Card for a modern dashboard feel
          const SizedBox(height: 16),
          const GreetingHeader(userName: 'My Company'),
          const SizedBox(height: 24),
          const BalanceCard(balance: '1,50,230.50'),
          const SizedBox(height: 32),

          // NEW: Primary actions styled differently for emphasis
          _buildSectionHeader(context, 'Quick Actions'),
          Row(
            children: primaryActions
                .map((item) => Expanded(child: _buildPrimaryActionCard(context, item)))
                .toList(),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader(context, 'Other Documents'),
          _buildResponsiveGrid(context,
              _showAllDocuments ? otherDocuments : otherDocuments.take(8).toList()),

          if (otherDocuments.length > 8) ...[
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                onPressed: () =>
                    setState(() => _showAllDocuments = !_showAllDocuments),
                child: Text(_showAllDocuments ? 'View Less' : 'View More'),
              ),
            ),
          ],
          const SizedBox(height: 24),

          _buildSectionHeader(context, 'More'),
          _buildResponsiveGrid(context, moreOptions),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // NEW: Header widget for sections
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  // NEW: Special card for primary actions
  Widget _buildPrimaryActionCard(BuildContext context, FeatureItemModel item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (item.onTap != null) {
            item.onTap!();
          } else if (item.route != null) {
            Navigator.pushNamed(context, item.route!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: item.color.withOpacity(0.15),
                child: Icon(item.icon, color: item.color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(item.title, style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }

  // NEW: Grid for other items
  Widget _buildGridItem(BuildContext context, FeatureItemModel item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          if (item.onTap != null) {
            item.onTap!();
          } else if (item.route != null) {
            Navigator.pushNamed(context, item.route!);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${item.title} clicked!')),
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, color: item.color, size: 32),
            const SizedBox(height: 12),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  // FIX: Updated grid to be more responsive to different screen sizes.
  Widget _buildResponsiveGrid(
      BuildContext context, List<FeatureItemModel> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100, // Each item will have a maximum width of 100
        childAspectRatio: 1.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildGridItem(context, items[index]);
      },
    );
  }
}

// NEW: Added route property to your model
class FeatureItemModel {
  final IconData icon;
  final String title;
  final Color color;
  final String? route; // Can be null
  final VoidCallback? onTap;

  FeatureItemModel({
    required this.icon,
    required this.title,
    required this.color,
    this.route,
    this.onTap,
  });
}