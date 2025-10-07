// lib/screens/invoice_settings_screen.dart

import 'dart:typed_data';

import 'package:accountbook/models/invoice_model.dart'; // <-- CORRECTED IMPORT
import 'package:accountbook/screens/pdf_preview_screen.dart';
import 'package:accountbook/services/pdf_generator.dart';
import 'package:accountbook/widgets/add_custom_field_dialog.dart'; // <-- ADDED IMPORT
import 'package:flutter/material.dart';

class InvoiceSettingsScreen extends StatefulWidget {
  const InvoiceSettingsScreen({super.key});

  @override
  State<InvoiceSettingsScreen> createState() => _InvoiceSettingsScreenState();
}

class _InvoiceSettingsScreenState extends State<InvoiceSettingsScreen> {
  String _selectedTemplate = 'Classic';

  // State variables for all the switches
  bool _bankAndUpi = true;
  bool _signature = true;
  bool _termsAndConditions = true;
  bool _transportDetails = true;
  bool _otherDetails = true;
  bool _additionalFields = true;
  bool _voucherDetails = true;
  bool _eInvoiceDetails = true;
  bool _receivePayment = true;
  bool _enableCashDiscount = true;
  bool _enableAdditionalCharges = true;
  bool _enableRoundOff = true;
  bool _autoGenerateEwaybill = false;
  bool _enableTcs = false;
  bool _businessSlogan = true;
  bool _bottomSlogan = true;
  bool _documentHeader = true;
  bool _originalDuplicate = true;
  bool _watermark = false;

  Future<void> _generateAndShowPdf(String template) async {
    setState(() => _selectedTemplate = template);

    // Create dummy data for the invoice
    final dummyData = InvoiceData(
      invoiceNumber: 'INV-001',
      date: DateTime.now(),
      companyName: 'My Company',
      companyAddress: '123 Business Rd, Business City, 12345',
      companyGstin: '27ABCDE1234F1Z5',
      buyerName: 'Ramesh Agarwal',
      buyerAddress: '456 Client St, Client Town, 67890',
      buyerGstin: '29KLMNO5678P1Z5',
      items: [
        InvoiceItem('Carbon', 2, 950.00, 0.05),
        InvoiceItem('Rubber Waste', 1, 475.00, 0.05),
      ],
    );
    
    showDialog(context: context, builder: (_) => const Center(child: CircularProgressIndicator()));

    Uint8List pdfData;
    switch (template) {
      case 'Tally':
        pdfData = await PdfGenerator.generateTallyInvoice(dummyData);
        break;
      case 'Clean':
        pdfData = await PdfGenerator.generateCleanInvoice(dummyData);
        break;
      case 'Detailed':
        pdfData = await PdfGenerator.generateDetailedInvoice(dummyData);
        break;
      case 'Classic':
      default:
        pdfData = await PdfGenerator.generateClassicInvoice(dummyData);
        break;
    }
    
    Navigator.of(context).pop(); // Dismiss loading indicator

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(pdfData: pdfData),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customise Invoice'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPdfTemplateSelector(),
          const SizedBox(height: 24),
          _buildPrimarySwitches(),
          const SizedBox(height: 24),
          _buildOptionalDetailsSection(),
          const SizedBox(height: 24),
          _buildPrimaryDetailsSection(),
           const SizedBox(height: 24),
          _buildDocumentSettingsSection(),
           const SizedBox(height: 24),
          _buildPdfSettingsSection(),
           const SizedBox(height: 24),
           TextButton.icon(
             icon: const Icon(Icons.refresh, color: Colors.red),
             label: const Text('Reset to default', style: TextStyle(color: Colors.red)),
             onPressed: (){
               // TODO: Implement reset logic
             },
           )
        ],
      ),
    );
  }

  Widget _buildPdfTemplateSelector() {
    final templates = ['Classic', 'Tally', 'Clean', 'Detailed'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Invoice PDF', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              final isSelected = _selectedTemplate == template;
              return GestureDetector(
                onTap: () => _generateAndShowPdf(template),
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description, color: isSelected ? Colors.blue : Colors.grey),
                      const SizedBox(height: 8),
                      Text(template),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPrimarySwitches() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildPrimarySwitchOption(
          context,
          icon: Icons.account_balance,
          label: 'Bank & UPI',
          value: _bankAndUpi,
          onChanged: (val) => setState(() => _bankAndUpi = val),
        ),
        _buildPrimarySwitchOption(
          context,
          icon: Icons.edit,
          label: 'Signature',
          value: _signature,
          onChanged: (val) => setState(() => _signature = val),
        ),
        _buildPrimarySwitchOption(
          context,
          icon: Icons.description,
          label: 'Terms & Conditions',
          value: _termsAndConditions,
          onChanged: (val) => setState(() => _termsAndConditions = val),
        ),
      ],
    );
  }

    Widget _buildPrimarySwitchOption(BuildContext context,
      {required IconData icon, required String label, required bool value, required ValueChanged<bool> onChanged}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
           decoration: BoxDecoration(
             border: Border.all(color: Colors.grey.shade300),
             borderRadius: BorderRadius.circular(8)
           ),
          child: Icon(icon, size: 28, color: Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
        Switch(
          value: value,
          onChanged: onChanged,
           activeTrackColor: Colors.blue.shade200,
          activeColor: Colors.blue,
        )
      ],
    );
  }


  Widget _buildOptionalDetailsSection() {
    return _buildSection(
      title: 'Optional Details',
      children: [
        _buildSwitchTile(
          title: 'Transport Details',
          value: _transportDetails,
          onChanged: (val) => setState(() => _transportDetails = val),
        ),
        _buildSwitchTile(
          title: 'Other Details',
          value: _otherDetails,
          onChanged: (val) => setState(() => _otherDetails = val),
        ),
        _buildSwitchTile(
          title: 'Additional Fields',
          value: _additionalFields,
          onChanged: (val) => setState(() => _additionalFields = val),
        ),
         ListTile(
           leading: const Icon(Icons.add, color: Colors.blue),
           title: const Text('Add Fields to Invoice', style: TextStyle(color: Colors.blue)),
           onTap: (){
               showDialog(context: context, builder: (_) => const AddCustomFieldDialog());
           },
         )
      ],
    );
  }

    Widget _buildPrimaryDetailsSection() {
    return _buildSection(
      title: 'Primary Details',
      children: [
       _buildNavTile(title: 'Voucher & E-Invoice Details'),
       _buildNavTile(title: 'Manage Company Details'),
       _buildNavTile(title: 'Manage Party Fields'),
       _buildNavTile(title: 'Manage Item Column'),
      ],
    );
  }

   Widget _buildDocumentSettingsSection() {
    return _buildSection(
      title: 'Document Settings',
      children: [
        _buildSwitchTile(
          title: 'Auto Settle Payment',
          value: false, // This seems to be off in the video initially
          onChanged: (val) {},
        ),
        _buildSwitchTile(
          title: 'Receive Payment When Creating Invoice',
          value: _receivePayment,
          onChanged: (val) => setState(() => _receivePayment = val),
        ),
         _buildSwitchTile(
          title: 'Enable Cash Discount',
          value: _enableCashDiscount,
          onChanged: (val) => setState(() => _enableCashDiscount = val),
        ),
         _buildSwitchTile(
          title: 'Enable Additional Charges',
          value: _enableAdditionalCharges,
          onChanged: (val) => setState(() => _enableAdditionalCharges = val),
        ),
         _buildSwitchTile(
          title: 'Enable Round off',
          value: _enableRoundOff,
          onChanged: (val) => setState(() => _enableRoundOff = val),
        ),
         _buildSwitchTile(
          title: 'Auto Generate E-waybill',
          value: _autoGenerateEwaybill,
          onChanged: (val) => setState(() => _autoGenerateEwaybill = val),
        ),
         _buildSwitchTile(
          title: 'Enable TCS For All Buyers',
          value: _enableTcs,
          onChanged: (val) => setState(() => _enableTcs = val),
        ),
       _buildNavTile(title: 'Prefix Management'),
      ],
    );
  }

   Widget _buildPdfSettingsSection() {
    return _buildSection(
      title: 'PDF Settings',
      children: [
        _buildSwitchTile(
          title: 'Business Slogan',
          value: _businessSlogan,
          onChanged: (val) => setState(() => _businessSlogan = val),
          hasEdit: true,
        ),
         _buildSwitchTile(
          title: 'Bottom Slogan',
          value: _bottomSlogan,
          onChanged: (val) => setState(() => _bottomSlogan = val),
          hasEdit: true,
        ),
         _buildSwitchTile(
          title: 'Document Header',
          value: _documentHeader,
          onChanged: (val) => setState(() => _documentHeader = val),
          hasEdit: true,
        ),
         _buildSwitchTile(
          title: 'Original / Duplicate / Triplicate',
          value: _originalDuplicate,
          onChanged: (val) => setState(() => _originalDuplicate = val),
           hasEdit: true,
        ),
         _buildSwitchTile(
          title: 'Watermark',
          value: _watermark,
          onChanged: (val) => setState(() => _watermark = val),
           hasEdit: true,
        ),
      ],
    );
  }


  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({required String title, required bool value, required ValueChanged<bool> onChanged, bool hasEdit = false}) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      secondary: hasEdit ? IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: (){}) : null,
       activeTrackColor: Colors.blue.shade200,
       activeColor: Colors.blue,
    );
  }

   Widget _buildNavTile({required String title}) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}