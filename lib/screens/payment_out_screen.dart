import 'package:flutter/material.dart';

class PaymentOutScreen extends StatelessWidget {
  const PaymentOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Out'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Payment Out Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}