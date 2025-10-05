import 'package:flutter/material.dart';

class CashflowScreen extends StatelessWidget {
  const CashflowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashflow'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child:
            Text('Cashflow Screen - Coming Soon!', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}