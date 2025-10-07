import 'package:flutter/material.dart';

class SetupDigitalSignatureScreen extends StatelessWidget {
  const SetupDigitalSignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Up Digital Signature'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text('Enjoy 3 Free Promo Credits!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            const Text('Why Digital Signature?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Signed by Gimbooks User'),
                    const Text('Date: 2025.02.25 17:57:41'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.grey.shade200,
                      child: const Text('AADHAAR'),
                    ),
                     const SizedBox(height: 8),
                    const Text('Authorised Signatory'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildFeatureItem(
              context,
              title: 'Enhanced Security',
              subtitle: 'They protect documents from unauthorized alterations.',
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              context,
              title: 'Fraud Prevention',
              subtitle:
                  'Digital signatures are backed by unique digita identities, making them highly secure and reducing the risk of forgery.',
            ),
            const SizedBox(height: 12),
            _buildFeatureItem(
              context,
              title: 'Legal Validity',
              subtitle:
                  'Digital signatures hold legal validity and are widely accepted.',
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Set Up Digital Signature'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context,
      {required String title, required String subtitle}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check, color: Colors.green),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),
        ),
      ],
    );
  }
}