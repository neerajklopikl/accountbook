import 'package:flutter/material.dart';

class DeliveryChallanScreen extends StatelessWidget {
  const DeliveryChallanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Challan'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Delivery Challan Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}