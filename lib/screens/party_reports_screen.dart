import 'package:flutter/material.dart';

class PartyReportsScreen extends StatelessWidget {
  const PartyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Party Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Party Reports Screen - Coming Soon!',
            style: TextStyle(fontSize: 20)),
      ),
    );
  }
}