import 'package:flutter/material.dart';

class ChangeNumberDialog extends StatelessWidget {
  final String transactionType;
  final String initialValue;

  const ChangeNumberDialog({
    super.key,
    required this.transactionType,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Change $transactionType No.'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Invoice Prefix'),
          const SizedBox(height: 8),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red.shade100,
                  side: BorderSide(color: Colors.red.shade700),
                ),
                child: Text('None', style: TextStyle(color: Colors.red.shade700)),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Add Prefix'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: '$transactionType No.',
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
          ),
          child: const Text('SAVE'),
        ),
      ],
    );
  }
}