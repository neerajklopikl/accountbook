import 'package:flutter/material.dart';

class StockReportsScreen extends StatelessWidget {
  const StockReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Stock Reports Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}