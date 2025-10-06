import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EstimateQuoteScreen extends StatefulWidget {
  const EstimateQuoteScreen({super.key});

  @override
  State<EstimateQuoteScreen> createState() => _EstimateQuoteScreenState();
}

class _EstimateQuoteScreenState extends State<EstimateQuoteScreen> {
  DateTime _quotationDate = DateTime.now();
  String _consigneeOption = 'same'; // 'same', 'not_required', 'different'

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _quotationDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _quotationDate) {
      setState(() {
        _quotationDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quotation'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopSection(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildDetailSection(
                    title: 'Supplier Details',
                    child: _buildTappableRow(
                      context,
                      label: 'My Company',
                      icon: Icons.edit,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Navigate to Edit Company screen')));
                      },
                    ),
                  ),
                  _buildDetailSection(
                    title: 'Buyer Details',
                    child: _buildTappableRow(
                      context,
                      label: 'Add Buyer',
                      isAdd: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Navigate to Buyer List')));
                      },
                    ),
                  ),
                  _buildDetailSection(
                    title: 'Consignee Details',
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Show Consignee (Same as above)'),
                          value: 'same',
                          groupValue: _consigneeOption,
                          onChanged: (value) =>
                              setState(() => _consigneeOption = value!),
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<String>(
                          title: const Text('Consignee Not Required'),
                          value: 'not_required',
                          groupValue: _consigneeOption,
                          onChanged: (value) =>
                              setState(() => _consigneeOption = value!),
                          contentPadding: EdgeInsets.zero,
                        ),
                        RadioListTile<String>(
                          title: const Text(
                              'Add Consignee (If different from above)'),
                          value: 'different',
                          groupValue: _consigneeOption,
                          onChanged: (value) =>
                              setState(() => _consigneeOption = value!),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  _buildDetailSection(
                    title: 'Contact Person Details',
                    child: _buildTappableRow(
                      context,
                      label: 'Add Contact Person',
                      isAdd: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Navigate to Add Contact screen')));
                      },
                    ),
                  ),
                  _buildDetailSection(
                    title: 'Product Details',
                    child: _buildTappableRow(
                      context,
                      label: 'Add Product',
                      isAdd: true,
                      onTap: () {
                        Navigator.pushNamed(context, '/addItem');
                      },
                    ),
                  ),
                  _buildDetailSection(
                    title: 'Other Details (Optional)',
                    child: _buildTappableRow(
                      context,
                      label: 'Add Other Details',
                      isAdd: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Show Other Details section')));
                      },
                    ),
                  ),
                  _buildDetailSection(
                    title: 'Bank Details (Optional)',
                    child: _buildTappableRow(
                      context,
                      label: 'Add Bank Details',
                      isAdd: true,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Navigate to Bank Details screen')));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildTopSection() {
    return Container(
      color: Colors.amber.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => _selectDate(context),
            child: _buildTopInfo(
                'Quotation Date', DateFormat('d-MM-yyyy').format(_quotationDate)),
          ),
          _buildTopInfo('Quotation Prefix', 'N/A'),
          _buildTopInfo('Quotation No', '1', alignEnd: true),
        ],
      ),
    );
  }

  Widget _buildTopInfo(String label, String value, {bool alignEnd = false}) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildDetailSection({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
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
            Icon(icon ?? Icons.notes_rounded, color: Colors.grey.shade700),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + MediaQuery.of(context).padding.bottom),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                '₹ 0.00',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save & Share clicked!')),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text('Save & Share'),
          )
        ],
      ),
    );
  }
}