import 'package:flutter/material.dart';

class EstimateQuoteScreen extends StatelessWidget {
  const EstimateQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimate/Quote'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Estimate/Quote Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}