import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateDebitNoteScreen extends StatefulWidget {
  const CreateDebitNoteScreen({super.key});

  @override
  State<CreateDebitNoteScreen> createState() => _CreateDebitNoteScreenState();
}

class _CreateDebitNoteScreenState extends State<CreateDebitNoteScreen> {
  String _noteType = 'debit_note'; // 'debit_note' or 'purchase_return'
  DateTime _noteDate = DateTime(2025, 10, 7);

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Wait, Are you sure you want to go back ?'),
            content: const Text('You will miss all the entered data.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_noteType == 'debit_note' ? 'Create Debit Note' : 'Create Purchase Return'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.amber.shade100,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'debit_note',
                          groupValue: _noteType,
                          onChanged: (val) => setState(() => _noteType = val!),
                        ),
                        const Text('Debit Note'),
                        Radio<String>(
                           value: 'purchase_return',
                          groupValue: _noteType,
                          onChanged: (val) => setState(() => _noteType = val!),
                        ),
                        const Text('Purchase Return'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Debit Note Date\n${DateFormat('dd-MM-yyyy').format(_noteDate)}'),
                        const Text('Debit Note No.\n1'),
                      ],
                    ),
                  ],
                ),
              ),
              // Form
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                     _buildDetailSection(
                      title: 'Firm Details',
                      child: _buildTappableRow(context, label: 'My Company', icon: Icons.edit, onTap: (){}),
                    ),
                     _buildDetailSection(
                      title: 'Seller Details',
                      child: _buildTappableRow(context, label: 'Add Seller', isAdd: true, icon: Icons.menu, onTap: (){}),
                    ),
                     _buildDetailSection(
                      title: 'Product Details',
                      child: _buildTappableRow(context, label: 'Add Product', isAdd: true, onTap: (){}),
                    ),
                     _buildDetailSection(
                      title: 'Transportation Details (Optional)',
                      child: _buildTappableRow(context, label: 'Add Transportation details', isAdd: true, onTap: (){}),
                    ),
                     _buildDetailSection(
                      title: 'Other Details (Optional)',
                      child: _buildTappableRow(context, label: 'Add Other Details', isAdd: true, onTap: (){}),
                    ),
                    _buildDetailSection(
                      title: 'Terms and Conditions',
                      child: const Text('This is an electronically generated document')
                    ),
                     _buildDetailSection(
                      title: 'Add Signature (Optional)',
                      child: SwitchListTile(value: false, onChanged: (val){}, title: const Text('Add Signature'))
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildDetailSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black54)),
          const Divider(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildTappableRow(BuildContext context,
      {required String label,
      IconData? icon,
      bool isAdd = false,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            if (isAdd)
              Icon(Icons.add_circle_outline,
                  color: Theme.of(context).primaryColor),
            if (isAdd) const SizedBox(width: 8),
            Expanded(
                child: Text(label,
                    style: TextStyle(
                        color: isAdd ? Theme.of(context).primaryColor : Colors.black,
                        fontSize: 16,
                        fontWeight: isAdd ? FontWeight.bold : FontWeight.normal
                        ))),
            if(icon != null) Icon(icon, color: Colors.grey.shade700),
          ],
        ),
      ),
    );
  }
}
