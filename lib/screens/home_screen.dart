// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import '../models/feature_item_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAllDocuments = false;

  @override
  Widget build(BuildContext context) {
    final documents = [
      FeatureItemModel(icon: Icons.receipt, title: 'Invoices', color: Colors.blue),
      FeatureItemModel(icon: Icons.request_quote, title: 'Quotation', color: Colors.orange),
      FeatureItemModel(icon: Icons.shopping_cart, title: 'Purchase', color: Colors.green),
    ];

    final otherDocuments = [
      FeatureItemModel(icon: Icons.receipt_long, title: 'e-Invoice', color: Colors.purple),
      FeatureItemModel(icon: Icons.local_shipping, title: 'e-Way Bills', color: Colors.blue),
      FeatureItemModel(icon: Icons.description, title: 'Proforma Invoices', color: Colors.teal),
      FeatureItemModel(icon: Icons.payment, title: 'Payment Receipts', color: Colors.redAccent),
      FeatureItemModel(icon: Icons.money_off, title: 'Payments Made', color: Colors.red),
      FeatureItemModel(icon: Icons.request_page, title: 'Debit Notes', color: Colors.green),
      FeatureItemModel(icon: Icons.credit_score, title: 'Credit Notes', color: Colors.blue),
      FeatureItemModel(icon: Icons.badge, title: 'Digital Signature', color: Colors.green),
      FeatureItemModel(icon: Icons.delivery_dining, title: 'Delivery Challans', color: Colors.orange),
      FeatureItemModel(icon: Icons.inventory, title: 'Inventory', color: Colors.blueGrey),
      FeatureItemModel(icon: Icons.book, title: 'Ledgers', color: Colors.indigo),
      FeatureItemModel(icon: Icons.bar_chart, title: 'Reports', color: Colors.green),
      FeatureItemModel(icon: Icons.money_off, title: 'Expenses', color: Colors.red),
      FeatureItemModel(icon: Icons.card_giftcard, title: 'Refund Voucher', color: Colors.pink),
      FeatureItemModel(icon: Icons.list_alt, title: 'Purchase Orders', color: Colors.teal),
      FeatureItemModel(icon: Icons.g_mobiledata, title: 'GSTR Filing', color: Colors.blue),
    ];

    final moreOptions = [
      FeatureItemModel(icon: Icons.card_giftcard, title: 'Festive Greetings', color: Colors.green),
      FeatureItemModel(icon: Icons.find_in_page, title: 'HSN/SAC Finder', color: Colors.red),
      FeatureItemModel(icon: Icons.qr_code_scanner, title: 'E-Invoice QR Scanner', color: Colors.blue),
    ];

    const int initialItemCount = 8; // Show 2 rows initially

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Top Document Cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: documents.map((item) => Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(item.icon, color: item.color, size: 30),
                    const SizedBox(height: 8),
                    Text('${item.title} ->', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 24),

        // Other Documents
        _buildSectionHeader('Other Documents'),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _showAllDocuments ? otherDocuments.length : (otherDocuments.length > initialItemCount ? initialItemCount : otherDocuments.length),
          itemBuilder: (context, index) {
            return _buildGridItem(context, otherDocuments[index]);
          },
        ),
        const SizedBox(height: 16),

        // Show "View More" / "View Less" button if there are more items
        if (otherDocuments.length > initialItemCount)
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  _showAllDocuments = !_showAllDocuments;
                });
              },
              child: Text(
                _showAllDocuments ? 'View Less' : 'View More',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        const SizedBox(height: 24),

        // More Section
        _buildSectionHeader('More'),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: moreOptions.length,
          itemBuilder: (context, index) {
            return _buildGridItem(context, moreOptions[index]);
          },
        ),
        const SizedBox(height: 24),

        // Ad Banner
        Card(
          color: Colors.transparent,
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: Image.network('https://i.imgur.com/K72V3oP.png'), // Placeholder URL for the ad banner
        ),
        const SizedBox(height: 80), // Space for the floating action button
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, FeatureItemModel item) {
    return InkWell(
      onTap: () {
        // TODO: Handle navigation or action for this item
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.title} tapped!')),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: item.color.withOpacity(0.15),
            radius: 25,
            child: Icon(item.icon, color: item.color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}