import 'package:flutter/material.dart';

class SaleInvoiceScreen extends StatelessWidget {
  const SaleInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Invoice'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Sale Invoice Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}