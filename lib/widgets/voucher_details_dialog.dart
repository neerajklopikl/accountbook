import 'package:flutter/material.dart';

class VoucherDetailsDialog extends StatefulWidget {
  const VoucherDetailsDialog({super.key});

  @override
  State<VoucherDetailsDialog> createState() => _VoucherDetailsDialogState();
}

class _VoucherDetailsDialogState extends State<VoucherDetailsDialog> {
  String _invoicePrefix = 'INV';
  DateTime _invoiceDate = DateTime.now();
  String _dueDate = 'No Due Date';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Voucher Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              DropdownButton<String>(
                value: _invoicePrefix,
                items: <String>['No Prefix', 'INV', '+ Add Prefix']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _invoicePrefix = newValue!;
                  });
                },
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Invoice Number',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: 'Invoice Date',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _invoiceDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _invoiceDate) {
                    setState(() {
                      _invoiceDate = picked;
                    });
                  }
                },
              ),
            ),
            readOnly: true,
            controller: TextEditingController(
                text: "${_invoiceDate.toLocal()}".split(' ')[0]),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: _dueDate,
                  items: <String>[
                    'No Due Date',
                    'Due on Receipt',
                    '15 Days',
                    '30 Days',
                    '45 Days',
                    '60 Days',
                    'Add New'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dueDate = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Due Date',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}