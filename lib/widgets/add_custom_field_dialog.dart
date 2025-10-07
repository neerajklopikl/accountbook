// lib/widgets/add_custom_field_dialog.dart

import 'package:flutter/material.dart';

class AddCustomFieldDialog extends StatelessWidget {
  const AddCustomFieldDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Custom Field'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Field Name',
            ),
          ),
          const SizedBox(height: 16),
           DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Entry Type',
            ),
            value: 'Text',
            items: ['Text', 'Number', 'Checkbox', 'Email', 'URL', 'Phone', 'Amount', 'Percent' ]
                .map((option) => DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    ))
                .toList(),
            onChanged: (value) {},
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 40)
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}