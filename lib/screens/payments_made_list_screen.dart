import 'package:flutter/material.dart';

class PaymentsMadeListScreen extends StatelessWidget {
  const PaymentsMadeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/createPaymentMade');
            },
            icon: const Icon(Icons.add, color: Colors.black),
            label: const Text(
              'Create New',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
      body: InkWell(
        onTap: () => Navigator.pushNamed(context, '/createPaymentMade'),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tap here to make your first Payment',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 8),
              Text('or'),
              SizedBox(height: 8),
              Text(
                'Use Create New button in the top',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
