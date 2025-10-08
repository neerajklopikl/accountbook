import 'dart:convert';
import 'package:accountbook/widgets/add_custom_field_dialog.dart';
import 'package:accountbook/widgets/bank_details_form.dart';
import 'package:accountbook/widgets/other_details_form.dart';
import 'package:accountbook/widgets/transport_details_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Data Models
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

class Customer {
    final String id;
    final String name;

    Customer({required this.id, required this.name});

    factory Customer.fromJson(Map<String, dynamic> json) {
        return Customer(
            id: json['_id'],
            name: json['name'],
        );
    }
}

class Item {
    final String id;
    final String name;
    final double rate;

    Item({required this.id, required this.name, required this.rate});

    factory Item.fromJson(Map<String, dynamic> json) {
        return Item(
            id: json['_id'],
            name: json['name'],
            rate: json['rate'].toDouble(),
        );
    }
}

class CreateInvoiceScreen extends StatefulWidget {
    const CreateInvoiceScreen({super.key});

    @override
    State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
    TransportDetails? _transportDetails;
    Map<String, String> _additionalFields = {};
    OtherDetails? _otherDetails;
    BankDetails? _bankDetails;
    String _termsAndConditions = '1. This is an electronically generated document.\\n2. All disputes are subject';

    List<Customer> _customers = [];
    Customer? _selectedCustomer;
    List<Item> _items = [];
    List<Item> _selectedItems = [];

    @override
    void initState() {
        super.initState();
        _fetchCustomers();
        _fetchItems();
    }

    Future<void> _fetchCustomers() async {
        try {
            final response = await http.get(Uri.parse('http://10.0.2.2:5001/api/customers'));
            if (response.statusCode == 200) {
                List<dynamic> customerList = json.decode(response.body);
                setState(() {
                    _customers = customerList.map((json) => Customer.fromJson(json)).toList();
                });
            }
        } catch (e) {
            // Handle error
        }
    }

    Future<void> _fetchItems() async {
        try {
            final response = await http.get(Uri.parse('http://10.0.2.2:5001/api/items'));
            if (response.statusCode == 200) {
                List<dynamic> itemList = json.decode(response.body);
                setState(() {
                    _items = itemList.map((json) => Item.fromJson(json)).toList();
                });
            }
        } catch (e) {
            // Handle error
        }
    }

    Future<void> _saveInvoice() async {
        if (_selectedCustomer == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please select a customer.'), backgroundColor: Colors.red),
            );
            return;
        }

        final invoiceData = {
            'invoiceNumber': 'INV-${DateTime.now().millisecondsSinceEpoch}',
            'customerName': _selectedCustomer!.name,
            'items': _selectedItems.map((item) => {'name': item.name, 'quantity': 1, 'rate': item.rate}).toList(),
            'totalAmount': _selectedItems.fold(0.0, (sum, item) => sum + item.rate),
            'transportDetails': _transportDetails?.toJson(),
            'additionalFields': _additionalFields,
            'otherDetails': _otherDetails?.toJson(),
            'bankDetails': _bankDetails?.toJson(),
            'termsAndConditions': _termsAndConditions,
        };

        try {
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
                        DropdownButtonFormField<Customer>(
                            value: _selectedCustomer,
                            hint: const Text('Select Customer'),
                            onChanged: (Customer? newValue) {
                                setState(() {
                                    _selectedCustomer = newValue;
                                });
                            },
                            items: _customers.map((Customer customer) {
                                return DropdownMenuItem<Customer>(
                                    value: customer,
                                    child: Text(customer.name),
                                );
                            }).toList(),
                        ),
                        const SizedBox(height: 24),
                        // Item Selection
                        // ... Add your item selection UI here ...
                        const SizedBox(height: 24),
                        const Text('Optional Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 8),

                        _buildOptionalDetailItem(
                            icon: Icons.local_shipping,
                            title: 'Transport Details',
                            onTap: () => _showFormDialog(context, 'Transport Details', const TransportDetailsForm()),
                        ),
                        _buildOptionalDetailItem(
                            icon: Icons.article_outlined,
                            title: 'Additional Fields',
                            isCustom: true,
                            onTap: () => showDialog(context: context, builder: (_) => const AddCustomFieldDialog()),
                        ),
                        _buildOptionalDetailItem(
                            icon: Icons.receipt_long,
                            title: 'Other Details',
                            onTap: () => _showFormDialog(context, 'Other Details', const OtherDetailsForm()),
                        ),
                        _buildOptionalDetailItem(
                            icon: Icons.account_balance,
                            title: 'Bank Details',
                            onTap: () => _showFormDialog(context, 'Bank Details', const BankDetailsForm()),
                        ),
                        _buildTermsAndConditions(),
                    ],
                ),
            ),
            bottomNavigationBar: _buildBottomBar(),
        );
    }

    void _showFormDialog(BuildContext context, String title, Widget form) {
        showDialog(
            context: context,
            builder: (context) {
                return AlertDialog(
                    title: Text(title),
                    content: form,
                    actions: [
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                            child: const Text('Save'),
                        )
                    ],
                );
            });
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
                onPressed: _saveInvoice,
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