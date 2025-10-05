import 'package:flutter/material.dart';

class SaleReturnScreen extends StatelessWidget {
  const SaleReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Return'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Sale Return Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}