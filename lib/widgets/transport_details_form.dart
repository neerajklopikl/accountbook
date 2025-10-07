import 'package:flutter/material.dart';

class TransportDetailsForm extends StatelessWidget {
  const TransportDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Mode of Transport'),
            items: const [
              DropdownMenuItem(value: 'Road', child: Text('Road')),
              DropdownMenuItem(value: 'Rail', child: Text('Rail')),
              DropdownMenuItem(value: 'Air', child: Text('Air')),
              DropdownMenuItem(value: 'Ship', child: Text('Ship')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'LR Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'LR Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Vehicle Number'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Approx Distance in KMS'),
          ),
          const SizedBox(height: 24),
          const Text('Transporter Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text('Select Transporter ID'),
            onTap: () {},
          ),
          const Divider(),
          const Text('Supplier Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Place of supply'),
            items: const [
              DropdownMenuItem(value: 'Andhra Pradesh', child: Text('Andhra Pradesh')),
              DropdownMenuItem(value: 'Delhi', child: Text('Delhi')),
              DropdownMenuItem(value: 'Karnataka', child: Text('Karnataka')),
              DropdownMenuItem(value: 'Maharashtra', child: Text('Maharashtra')),
              DropdownMenuItem(value: 'Tamil Nadu', child: Text('Tamil Nadu')),
              DropdownMenuItem(value: 'Uttar Pradesh', child: Text('Uttar Pradesh')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Date of supply',
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
           const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Supply Type'),
            items: const [
              DropdownMenuItem(value: 'B2B', child: Text('B2B')),
              DropdownMenuItem(value: 'B2C', child: Text('B2C')),
            ],
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}