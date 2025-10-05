import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

enum InvoiceType { taxInvoice, billOfSupply }

class _AddSaleScreenState extends State<AddSaleScreen> {
  DateTime _selectedDate = DateTime.now();
  int _invoiceNumber = 1;
  InvoiceType _invoiceType = InvoiceType.taxInvoice;

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Create Invoice'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/txnSettings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInvoiceTypeSelector(),
            _buildInvoiceDetailsCard(context),
            _buildMyCompanyCard(context),
            _buildBuyerDetailsCard(context),
            _buildItemsServicesCard(context),
            _buildOptionalDetailsCard(context),
            const SizedBox(height: 80), // Space for the bottom bar
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildInvoiceTypeSelector() {
    return Container(
      color: Colors.amber,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: RadioListTile<InvoiceType>(
              title: const Text('Tax Invoice/E-Invoice', style: TextStyle(fontSize: 14)),
              value: InvoiceType.taxInvoice,
              groupValue: _invoiceType,
              onChanged: (InvoiceType? value) {
                setState(() {
                  _invoiceType = value!;
                });
              },
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: RadioListTile<InvoiceType>(
              title: const Text('Bill Of Supply', style: TextStyle(fontSize: 14)),
              value: InvoiceType.billOfSupply,
              groupValue: _invoiceType,
              onChanged: (InvoiceType? value) {
                setState(() {
                  _invoiceType = value!;
                });
              },
              activeColor: Colors.black,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceDetailsCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text('INV$_invoiceNumber'),
        subtitle: Row(
          children: [
            const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(DateFormat('dd-MM-yyyy').format(_selectedDate)),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _selectDate(context),
      ),
    );
  }

  Widget _buildMyCompanyCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ListTile(
            title: const Text('My Company'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('My Company clicked!')),
              );
            },
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: OutlinedButton(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Complete Business Profile clicked!')),
                );
              },
              style: OutlinedButton.styleFrom(
                 side: BorderSide(color: Colors.grey.shade300),
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Complete Business Profile'),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTitledCard({required IconData icon, required String title, required Widget child}) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.grey[700]),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildBuyerDetailsCard(BuildContext context) {
    return _buildTitledCard(
      icon: Icons.person_outline,
      title: 'Buyer Details',
      child: ElevatedButton.icon(
        onPressed: () {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Select Buyer clicked!')),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Select Buyer'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[100],
          foregroundColor: Colors.amber[800],
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildItemsServicesCard(BuildContext context) {
    return _buildTitledCard(
      icon: Icons.inventory_2_outlined,
      title: 'Items / Services',
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/addItem');
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber[100],
          foregroundColor: Colors.amber[800],
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
      ),
    );
  }

  Widget _buildOptionalDetailsCard(BuildContext context) {
     return Card(
      margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
       child: ExpansionTile(
         title: const Text('Optional Details'),
         children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Text('Add optional details like notes, terms, etc. here.'),
           )
         ],
       ),
     );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Invoice Amount', style: TextStyle(fontSize: 16)),
              Text('₹ 0.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text('Save Invoice'),
          ),
        ],
      ),
    );
  }
}