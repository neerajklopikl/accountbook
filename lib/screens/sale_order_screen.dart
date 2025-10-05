import 'package:flutter/material.dart';

class SaleOrderScreen extends StatelessWidget {
  const SaleOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Order'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Sale Order Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}