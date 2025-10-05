import 'package:flutter/material.dart';

class OtherIncomeScreen extends StatelessWidget {
  const OtherIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Income'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Other Income Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}