import 'package:accountbook/widgets/change_number_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentInScreen extends StatefulWidget {
  const PaymentInScreen({super.key});

  @override
  State<PaymentInScreen> createState() => _PaymentInScreenState();
}

class _PaymentInScreenState extends State<PaymentInScreen> {
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
        title: const Text('Payment-In'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/txnSettings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Customer Name *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Received',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (_) => const ChangeNumberDialog(
                    transactionType: 'Receipt', initialValue: '1'));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Receipt No.', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Text('1',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () => _selectDate(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Date', style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Text(DateFormat('dd/MM/yyyy').format(_selectedDate),
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Save & New'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Save'),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.adaptive.share),
          ),
        ],
      ),
    );
  }
}