import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // FIX: Added http import

// TODO: Move these data models to their own files
class TransportDetails {
  String vehicleNo;
  String driverName;
  TransportDetails({this.vehicleNo = '', this.driverName = ''});
  Map<String, dynamic> toJson() => {'vehicleNo': vehicleNo, 'driverName': driverName};
}

class OtherDetails {
  String notes;
  OtherDetails({this.notes = ''});
  Map<String, dynamic> toJson() => {'notes': notes};
}

class BankDetails {
  String accountHolderName;
  String accountNumber;
  BankDetails({this.accountHolderName = '', this.accountNumber = ''});
  Map<String, dynamic> toJson() => {'accountHolderName': accountHolderName, 'accountNumber': accountNumber};
}

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  // State for optional details
  TransportDetails? _transportDetails;
  Map<String, String> _additionalFields = {};
  OtherDetails? _otherDetails;
  BankDetails? _bankDetails;
  String _termsAndConditions = '1. This is an electronically generated document.\\n2. All disputes are subject';

  Future<void> _saveInvoice() async {
    final invoiceData = {
      'invoiceNumber': 'INV-${DateTime.now().millisecondsSinceEpoch}', // Example unique number
      'buyerName': 'Test Buyer', // TODO: Replace with actual buyer
      'items': [], // TODO: Replace with actual items
      'totalAmount': 0.00, // TODO: Replace with actual total
      'transportDetails': _transportDetails?.toJson(),
      'additionalFields': _additionalFields,
      'otherDetails': _otherDetails?.toJson(),
      'bankDetails': _bankDetails?.toJson(),
      'termsAndConditions': _termsAndConditions,
    };

    try {
      // FIX: Used http.post
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5001/api/invoices'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(invoiceData),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invoice saved successfully!'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save invoice: ${response.body}'), backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving invoice: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Create Invoice', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ... (Your existing 'Items / Services' Card) ...
            const SizedBox(height: 24),

            const Text('Optional Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            _buildOptionalDetailItem(
              icon: Icons.local_shipping,
              title: 'Transport Details',
              onTap: () => _addTransportDetails(),
            ),
            _buildOptionalDetailItem(
              icon: Icons.article_outlined,
              title: 'Additional Fields',
              isCustom: true,
              onTap: () => _addAdditionalFields(),
            ),
            _buildOptionalDetailItem(
              icon: Icons.receipt_long,
              title: 'Other Details',
              onTap: () => _addOtherDetails(),
            ),
            _buildOptionalDetailItem(
              icon: Icons.account_balance,
              title: 'Bank Details',
              onTap: () => _addBankDetails(),
            ),
            _buildTermsAndConditions(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // Methods to add/edit details (showing dialogs as examples)
  void _addTransportDetails() {
     // TODO: Replace with navigation to a dedicated screen
    setState(() => _transportDetails = TransportDetails(vehicleNo: 'AB-123'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transport Details Added')));
  }

  void _addAdditionalFields() {
    // TODO: Replace with a proper UI to manage key-value pairs
    setState(() => _additionalFields['Custom Field'] = 'Custom Value');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Additional Field Added')));
  }

  void _addOtherDetails() {
    // TODO: Replace with navigation to a dedicated screen
    setState(() => _otherDetails = OtherDetails(notes: 'Handle with care'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Other Details Added')));
  }

  void _addBankDetails() {
    // TODO: Replace with navigation to a dedicated screen
    setState(() => _bankDetails = BankDetails(accountHolderName: 'My Company', accountNumber: '123456789'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bank Details Added')));
  }

  Widget _buildOptionalDetailItem({
    required IconData icon,
    required String title,
    bool isCustom = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700]),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          OutlinedButton.icon(
            onPressed: onTap,
            icon: const Icon(Icons.add, size: 18),
            label: Text(isCustom ? 'Add Fields' : 'Add'),
             style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade400),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(Icons.description, color: Colors.grey[700]),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            hint: const Text('Terms and Conditions'),
            value: _termsAndConditions,
            items: [
              DropdownMenuItem(
                value: _termsAndConditions,
                child: Text(_termsAndConditions, overflow: TextOverflow.ellipsis, maxLines: 2),
              ),
              // TODO: Add more T&C options
            ],
            onChanged: (value) {
              if (value != null) setState(() => _termsAndConditions = value);
            },
          ),
        ),
      ]),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _saveInvoice, // Trigger the save function
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.amber,
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: const Text('Save Invoice', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}