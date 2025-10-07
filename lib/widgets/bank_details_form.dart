import 'package:flutter/material.dart';

class BankDetailsForm extends StatelessWidget {
  const BankDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'IFSC Code'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Bank name *',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Account Holder Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Account Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Enter UPI ID',
              hintText: 'Enter UPI ID to show UPI Payment QR Code in invoice PDF',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Branch Name'),
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title: const Text('Additional Details'),
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Swift Code'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'IBAN number'),
              ),
            ],
          )
        ],
      ),
    );
  }
}