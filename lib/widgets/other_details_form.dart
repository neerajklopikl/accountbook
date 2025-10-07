import 'package:flutter/material.dart';

class OtherDetailsForm extends StatefulWidget {
  const OtherDetailsForm({super.key});

  @override
  State<OtherDetailsForm> createState() => _OtherDetailsFormState();
}

class _OtherDetailsFormState extends State<OtherDetailsForm> {
  bool _reverseCharge = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CheckboxListTile(
            title: const Text('Reverse Charge Applicable'),
            value: _reverseCharge,
            onChanged: (value) {
              setState(() {
                _reverseCharge = value!;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const SizedBox(height: 16),
          const Text('Purchase Order Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          TextFormField(
            decoration: const InputDecoration(labelText: 'PO Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'PO Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Challan Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'eWay Bill Number'),
          ),
        ],
      ),
    );
  }
}