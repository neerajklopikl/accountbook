// lib/screens/add_txn_bottom_sheet.dart

import 'package:flutter/material.dart';

class AddTxnBottomSheet extends StatelessWidget {
  const AddTxnBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // FIX: Constrain the height to about 75% of the screen and make it a column
      // to properly layout the TabBar and TabBarView.
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Transaction Details'),
                Tab(text: 'Party Details'),
              ],
            ),
            // FIX: Added Expanded and TabBarView to make tabs functional.
            Expanded(
              child: TabBarView(
                children: [
                  // FIX: Wrapped the content in a SingleChildScrollView to prevent overflow.
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Sale Transactions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            childAspectRatio: 2.2,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildTxnItem(context,
                                  Icons.file_download_done_outlined, 'Payment-in', '/paymentIn'),
                              _buildTxnItem(context, Icons.file_upload_outlined,
                                  'Sale Return', '/saleReturn'),
                              _buildTxnItem(
                                  context,
                                  Icons.local_shipping_outlined,
                                  'Delivery Challan',
                                  '/deliveryChallan'),
                              _buildTxnItem(context, Icons.request_quote_outlined,
                                  'Estimate/Quot...', '/estimateQuote'),
                              _buildTxnItem(context, Icons.receipt_long_outlined,
                                  'Sale Order', '/saleOrder'),
                              _buildTxnItem(context, Icons.receipt_outlined,
                                  'Sale Invoice', '/saleInvoice'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Purchase Transactions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            childAspectRatio: 2.2,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildTxnItem(context, Icons.shopping_cart_outlined,
                                  'Purchase', '/addPurchase'), // Corrected route
                              _buildTxnItem(context, Icons.file_upload_outlined,
                                  'Payment-Out', '/paymentOut'),
                              _buildTxnItem(
                                  context,
                                  Icons.shopping_cart_checkout_outlined,
                                  'Purchase Return',
                                  '/purchaseReturn'),
                              _buildTxnItem(context, Icons.receipt_long_outlined,
                                  'Purchase Order', '/purchaseOrder'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text('Other Transactions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 8),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            childAspectRatio: 2.2,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              _buildTxnItem(context, Icons.wallet_outlined,
                                  'Expenses', '/expense'),
                              _buildTxnItem(context, Icons.people_alt_outlined,
                                  'P2P Transfer', '/p2pTransfer'), // Corrected route
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Placeholder for the second tab
                  const Center(
                    child: Text('Party Details - Coming Soon!'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTxnItem(
      BuildContext context, IconData icon, String label, String? routeName) {
    return InkWell(
      onTap: () {
        if (routeName != null) {
          Navigator.pop(context); // Close the bottom sheet
          Navigator.pushNamed(context, routeName);
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$label is not yet implemented.')),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}