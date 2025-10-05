import 'package:flutter/material.dart';

class BillWiseProfitScreen extends StatelessWidget {
  const BillWiseProfitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Wise Profit'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Bill Wise Profit Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}