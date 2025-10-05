import 'package:flutter/material.dart';

class PaymentInScreen extends StatelessWidget {
  const PaymentInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment In'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Payment In Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}