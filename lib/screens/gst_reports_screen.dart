import 'package:flutter/material.dart';

class GstReportsScreen extends StatelessWidget {
  const GstReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('GST Reports Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}