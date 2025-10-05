import 'package:flutter/material.dart';

class DayBookScreen extends StatelessWidget {
  const DayBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Book'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child:
            Text('Day Book Screen - Coming Soon!', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}