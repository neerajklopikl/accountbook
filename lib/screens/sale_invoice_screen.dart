// lib/screens/sale_invoice_screen.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

class SaleInvoiceScreen extends StatefulWidget {
  const SaleInvoiceScreen({super.key});

  @override
  State<SaleInvoiceScreen> createState() => _SaleInvoiceScreenState();
}

class _SaleInvoiceScreenState extends State<SaleInvoiceScreen> {
  int _selectedTabIndex = 0; // 0 for "All", 1 for "E-Invoices"

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const _FilterOptionsSheet();
      },
    );
  }

  void _showSetupEInvoiceSheet(BuildContext context) {
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
              child: const Text('One-time setup', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            const Text(
              'Link your E-invoice account with AccountBook',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                Navigator.pushNamed(context, '/eInvoiceLogin');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50)
              ),
              child: const Text('Setup Now'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/addSale');
            },
            icon: const Icon(Icons.edit_outlined, color: Colors.black),
            label: const Text(
              'Create New',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF0F2F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(context),
            const SizedBox(height: 16),
            _buildTabs(),
            const SizedBox(height: 16),
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildAllInvoicesView()
                  : _buildEInvoicesView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => setState(() => _selectedTabIndex = 0),
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedTabIndex == 0 ? Theme.of(context).primaryColor : Colors.white,
            foregroundColor: _selectedTabIndex == 0 ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: const Text('All'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => setState(() => _selectedTabIndex = 1),
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedTabIndex == 1 ? Theme.of(context).primaryColor : Colors.white,
            foregroundColor: _selectedTabIndex == 1 ? Colors.white : Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: const Text('E-Invoices'),
        ),
      ],
    );
  }

  Widget _buildAllInvoicesView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundColor: const Color(0xFFFAF3E0).withOpacity(0.7),
            child: const Icon(Icons.description_outlined, size: 70, color: Colors.amber),
          ),
          const SizedBox(height: 24),
          const Text('Create your first Invoice', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(width: 60, height: 60, child: CustomPaint(painter: DottedArrowPainter())),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/addSale'),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Create Invoice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEInvoicesView(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('E-Invoice', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Placeholder text...'),
                      Text('More placeholder text...'),
                    ],
                  ),
                ),
                Icon(Icons.qr_code_2, size: 50, color: Colors.black),
              ],
            ),
          ),
        ),
        const Spacer(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('E-Invoice Setup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _showSetupEInvoiceSheet(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Setup E-Invoice'),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

// ... DottedArrowPainter and _FilterOptionsSheet classes remain here as before ...

class DottedArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // ... painter code remains the same
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _FilterOptionsSheet extends StatefulWidget {
  const _FilterOptionsSheet();

  @override
  State<_FilterOptionsSheet> createState() => _FilterOptionsSheetState();
}

class _FilterOptionsSheetState extends State<_FilterOptionsSheet> {
  // ... state and build method remain the same
}