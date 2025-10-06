import 'package:flutter/material.dart';

class BankDetailsScreen extends StatelessWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Details'),
      ),
      body: const Center(
        child: Text('Bank Details Screen'),
      ),
    );
  }
}
