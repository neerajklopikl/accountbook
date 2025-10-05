import 'package:flutter/material.dart';

class TransactionSettingsScreen extends StatelessWidget {
  const TransactionSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Settings'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Transaction Settings Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}