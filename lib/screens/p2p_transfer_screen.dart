import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class P2PTransferScreen extends StatefulWidget {
  const P2PTransferScreen({super.key});

  @override
  State<P2PTransferScreen> createState() => _P2PTransferScreenState();
}

class _P2PTransferScreenState extends State<P2PTransferScreen> {
  DateTime _selectedDate = DateTime(2025, 10, 6);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('P2P Transfer'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => _selectDate(context),
                child: Text(
                  'Date: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildTransferBlock(),
            const SizedBox(height: 16),
            _buildTransferBlock(isPaid: true),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Add Note',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferBlock({bool isPaid = false}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Party *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ToggleButtons(
                  isSelected: [!isPaid, isPaid],
                  onPressed: (index) {
                    // Dummy onPressed
                  },
                  borderRadius: BorderRadius.circular(8),
                  selectedColor: Colors.white,
                  fillColor: isPaid ? Colors.red : Colors.green,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Received'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Paid'),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}