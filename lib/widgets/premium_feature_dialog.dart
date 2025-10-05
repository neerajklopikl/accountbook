import 'package:flutter/material.dart';

class PremiumFeatureDialog extends StatelessWidget {
  const PremiumFeatureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Unlock Premium Feature'),
      content: const Text(
          'This feature is available in the premium version. Please upgrade to unlock.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement upgrade logic
            Navigator.of(context).pop();
          },
          child: const Text('Upgrade'),
        ),
      ],
    );
  }
}