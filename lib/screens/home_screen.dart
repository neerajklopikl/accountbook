// lib/screens/home_screen.dart

import 'package/flutter/material.dart';
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
    
    const int initialItemCount = 8;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        int crossAxisCount;
        double childAspectRatio;

        if (width > 1200) {
          crossAxisCount = 8;
          childAspectRatio = 1.1; 
        } else if (width > 800) {
          crossAxisCount = 6;
          childAspectRatio = 1; 
        } else {
          crossAxisCount = 4;
          childAspectRatio = 0.85; 
        }
        
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                Row(
                  children: documents.map((item) => Expanded(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
                        child: Column(
                          children: [
                            Icon(item.icon, color: item.color, size: 32),
                            const SizedBox(height: 12),
                            Text('${item.title} ->', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 32),

                _buildSectionHeader('Other Documents'),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _showAllDocuments ? otherDocuments.length : (otherDocuments.length > initialItemCount ? initialItemCount : otherDocuments.length),
                  itemBuilder: (context, index) {
                    return _buildGridItem(context, otherDocuments[index]);
                  },
                ),
                const SizedBox(height: 8),

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

                _buildSectionHeader('More'),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: moreOptions.length,
                  itemBuilder: (context, index) {
                    return _buildGridItem(context, moreOptions[index]);
                  },
                ),
                const SizedBox(height: 32),

                _buildQuickLinksSection(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Links',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickLinkItem(context, icon: Icons.add_box_outlined, label: 'Add Txn', color: Colors.red.shade400, onTap: () {}),
                _buildQuickLinkItem(context, icon: Icons.summarize_outlined, label: 'Sale Report', color: Colors.blue.shade400, onTap: () => Navigator.pushNamed(context, '/saleReport')),
                _buildQuickLinkItem(context, icon: Icons.settings_outlined, label: 'Txn Settings', color: Colors.blue.shade400, onTap: () => Navigator.pushNamed(context, '/txnSettings')),
                _buildQuickLinkItem(context, icon: Icons.arrow_forward, label: 'Show All', color: Colors.blue.shade400, onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickLinkItem(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, FeatureItemModel item) {
    bool isMobile = MediaQuery.of(context).size.width < 700;

    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.title} tapped!')),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
         decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: item.color.withOpacity(0.15),
              radius: isMobile ? 24 : 28,
              child: Icon(item.icon, color: item.color, size: isMobile ? 26 : 30),
            ),
            const SizedBox(height: 8), 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 11 : 13, fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

