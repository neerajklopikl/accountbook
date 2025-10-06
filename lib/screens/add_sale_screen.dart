import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/voucher_details_dialog.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  String _invoiceType = 'Tax Invoice/E-Invoice';
  String _invoiceNumber = 'INV-1';
  DateTime _selectedDate = DateTime(2025, 10, 6);

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure you want to go back?'),
            content: const Text('All entered data will be cleared'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void _showVoucherDetailsDialog() {
    showDialog(
      context: context,
      builder: (context) => const VoucherDetailsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Invoice'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigate to settings or show a dialog
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Invoice Type Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'Tax Invoice/E-Invoice',
                    groupValue: _invoiceType,
                    onChanged: (String? value) {
                      setState(() {
                        _invoiceType = value!;
                      });
                    },
                  ),
                  const Text('Tax Invoice/E-Invoice'),
                  Radio<String>(
                    value: 'Bill Of Supply',
                    groupValue: _invoiceType,
                    onChanged: (String? value) {
                      setState(() {
                        _invoiceType = value!;
                      });
                    },
                  ),
                  const Text('Bill Of Supply'),
                ],
              ),
              const SizedBox(height: 16),

              // Invoice Number and Date
              ListTile(
                title: Text(_invoiceNumber),
                subtitle: Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _showVoucherDetailsDialog,
              ),

              // My Company Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const ListTile(
                        title: Text('My Company'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Complete Business Profile >'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Buyer Details
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Buyer Details',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Select Buyer'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Items / Services Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Items / Services',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/addItem');
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add Item'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Optional Details
              ExpansionTile(
                title: const Text(
                  'Optional Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                initiallyExpanded: false,
                children: [
                  _buildOptionalDetailItem(
                    icon: Icons.local_shipping,
                    title: 'Transport Details',
                  ),
                  _buildOptionalDetailItem(
                    icon: Icons.post_add,
                    title: 'Additional Fields',
                    isCustom: true,
                  ),
                  _buildOptionalDetailItem(
                    icon: Icons.article,
                    title: 'Other Details',
                  ),
                  _buildOptionalDetailItem(
                    icon: Icons.account_balance,
                    title: 'Bank Details',
                  ),
                  _buildTermsAndConditions(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildOptionalDetailItem({
    required IconData icon,
    required String title,
    bool isCustom = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: Text(isCustom ? 'Add Fields' : 'Add'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.grey.shade200,
              foregroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Icon(Icons.description, color: Colors.grey[700]),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Terms and Conditions',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              value: '1',
              items: [
                DropdownMenuItem(
                  value: '1',
                  child: Text(
                    '1. This is an electronically generated document.\\n2. All disputes are subject',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Invoice Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                '₹ 0.00',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save Invoice clicked!')),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text('Save Invoice'),
          ),
        ],
      ),
    );
  }
}