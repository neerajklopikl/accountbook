import 'package:flutter/material.dart';

class CreateCreditNoteScreen extends StatefulWidget {
  const CreateCreditNoteScreen({super.key});

  @override
  State<CreateCreditNoteScreen> createState() => _CreateCreditNoteScreenState();
}

class _CreateCreditNoteScreenState extends State<CreateCreditNoteScreen> {
  String _noteType = 'credit_note'; // or 'sale_return'

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
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black),
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
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          title: Text(
              _noteType == 'credit_note' ? 'Create Credit Note' : 'Create Sale Return'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.amber.shade100,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'credit_note',
                          groupValue: _noteType,
                          onChanged: (val) => setState(() => _noteType = val!),
                        ),
                        const Text('Credit Note'),
                        const SizedBox(width: 20),
                        Radio<String>(
                          value: 'sale_return',
                          groupValue: _noteType,
                          onChanged: (val) => setState(() => _noteType = val!),
                        ),
                        const Text('Sale Return'),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Credit Note Date\n7-10-2025'),
                        Text('Credit Note No.\n1'),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow(label: 'Supplier Details'),
                    _buildDetailRow(label: 'My Company', hasEdit: true),
                    _buildDetailRow(label: 'Buyer Details'),
                    _buildDetailRow(label: 'Add Buyer', isAdd: true),
                    _buildDetailRow(label: 'Product Details'),
                    _buildDetailRow(label: 'Add Product', isAdd: true),
                    _buildDetailRow(label: 'Transportation Details ( Optional )', isAdd: true),
                    _buildDetailRow(label: 'Other Details ( Optional )', isAdd: true),
                    _buildDetailRow(label: 'Terms and Conditions'),
                    const ListTile(
                      title: Text('This is an electronically generated document'),
                    ),
                    _buildDetailRow(label: 'Add Signature ( Optional )'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String label, bool isAdd = false, bool hasEdit = false}) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: isAdd ? const Icon(Icons.add, color: Colors.amber) : null,
          title: Text(label),
          trailing: hasEdit
              ? const Icon(Icons.edit, color: Colors.amber)
              : (isAdd ? const Icon(Icons.menu) : null),
        ),
        const Divider(),
      ],
    );
  }
}