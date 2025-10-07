// lib/screens/invoice_settings_screen.dart

import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/invoice_model.dart';
import 'pdf_preview_screen.dart';
import '../services/pdf_generator.dart';
import '../widgets/add_custom_field_dialog.dart';

class InvoiceSettingsScreen extends StatefulWidget {
  const InvoiceSettingsScreen({super.key});

  @override
  State<InvoiceSettingsScreen> createState() => _InvoiceSettingsScreenState();
}

class _InvoiceSettingsScreenState extends State<InvoiceSettingsScreen> {
  String _selectedTemplate = 'Classic';

  // State for all the switches from the video
  bool _bankAndUpi = true;
  bool _signature = true;
  bool _termsAndConditions = true;
  bool _transportDetails = true;
  bool _otherDetails = true;
  bool _additionalFields = true;
  bool _autoSettlePayment = false;
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

    final dummyData = InvoiceData(
      companyName: 'Agarwal Industries Private Limited',
      companyAddress: 'NILA, NOIDA, Madhya Pradesh, 201301\nEmail: example@example.com',
      companyGstin: '23AAAPG7885R002',
      invoiceNumber: 'INV1',
      invoiceDate: DateTime(2023, 5, 24),
      poNumber: 'PO Number',
      transporterName: 'Transporter Name',
      ewayBillNumber: '54646554745',
      dispatchFrom: 'G DANIAL INDUSTRIAL AREA, RAIPUR, Chhattisgarh, 492001',
      buyerName: 'RAJESH AGARWAL',
      buyerAddress: 'INDUSTRIAL AREA, RAIPUR, Chhattisgarh, 402001',
      buyerGstin: '05AAAPG7885R002',
      items: [
        InvoiceItem(
            srNo: 1, name: 'Carbon', hsnSac: '2701001', quantity: 2, unit: 'TON',
            rate: 1000.00, discount: 5.00, taxableValue: 1900.00, igstRate: 18.00,
            igstAmount: 342.00, total: 2337.00, cgstAmount: 0, sgstAmount: 0),
        InvoiceItem(
            srNo: 2, name: 'Rubber Waste', hsnSac: '2901001', quantity: 1, unit: 'TON',
            rate: 500.00, discount: 5.00, taxableValue: 475.00, igstRate: 5.00,
            igstAmount: 23.75, total: 522.50, cgstAmount: 0, sgstAmount: 0),
      ],
      totalAmount: 3716.00,
      totalAmountInWords: 'Two Thousand Eight Hundred Fifty Nine Rupees and Fifty Paisa Only',
      bankAccountNo: '1234567890ybl',
      bankIfsc: 'IFSC0002234',
      bankName: 'Bank of India',
      upiId: '1234567890@ybl',
      termsAndConditions: [
        '1. Subject to Raipur Jurisdiction.',
        '2. Our responsibility ceases after the goods have been dispatched.',
      ],
    );
    
    showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator()));

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
    
    Navigator.of(context).pop(); // Close loading indicator

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfPreviewScreen(pdfData: pdfData),
        ),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customise Invoice'),
        elevation: 1,
        shadowColor: Colors.black26,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildTopBanner(),
          const SizedBox(height: 24),
          _buildPdfTemplateSelector(),
          const SizedBox(height: 24),
          _buildPrimarySwitches(),
          const SizedBox(height: 24),
          _buildOptionalDetails(),
          const SizedBox(height: 16),
          _buildPrimaryDetails(),
          const SizedBox(height: 16),
          _buildDocumentSettings(),
          const SizedBox(height: 16),
          _buildPdfSettings(),
          const SizedBox(height: 24),
          _buildResetButton(),
        ],
      ),
    );
  }

  Widget _buildTopBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Customise your own\nInvoice Format?', style: TextStyle(fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: const Text('Get It Now'),
          ),
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
                      color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description, color: isSelected ? Theme.of(context).primaryColor : Colors.grey),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPrimarySwitchItem(
          icon: Icons.account_balance,
          label: 'Bank & UPI',
          value: _bankAndUpi,
          onChanged: (val) => setState(() => _bankAndUpi = val),
        ),
        _buildPrimarySwitchItem(
          icon: Icons.draw,
          label: 'Signature',
          value: _signature,
          onChanged: (val) => setState(() => _signature = val),
        ),
        _buildPrimarySwitchItem(
          icon: Icons.library_books,
          label: 'Terms &\nConditions',
          value: _termsAndConditions,
          onChanged: (val) => setState(() => _termsAndConditions = val),
        ),
      ],
    );
  }

  Widget _buildPrimarySwitchItem({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.grey.shade700),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center),
        const SizedBox(height: 4),
        Switch(
          value: value,
          onChanged: onChanged,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }

  Widget _buildExpansionTileCard({required String title, required List<Widget> children, bool initiallyExpanded = true}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: initiallyExpanded,
        children: children,
      ),
    );
  }
  
  Widget _buildOptionalDetails() {
    return _buildExpansionTileCard(
      title: 'Optional Details',
      children: [
        _buildSwitchTile(
          icon: Icons.local_shipping,
          title: 'Transport Details',
          value: _transportDetails,
          onChanged: (val) => setState(() => _transportDetails = val),
        ),
        _buildSwitchTile(
          icon: Icons.article_outlined,
          title: 'Other Details',
          value: _otherDetails,
          onChanged: (val) => setState(() => _otherDetails = val),
        ),
        _buildSwitchTile(
          icon: Icons.add_box_outlined,
          title: 'Additional Fields',
          value: _additionalFields,
          onChanged: (val) => setState(() => _additionalFields = val),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextButton.icon(
            onPressed: () => showDialog(context: context, builder: (_) => const AddCustomFieldDialog()),
            icon: const Icon(Icons.add),
            label: const Text('Add Fields to Invoice'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildPrimaryDetails() {
     return _buildExpansionTileCard(
      title: 'Primary Details',
      children: [
        _buildNavTile(title: 'Voucher & E-Invoice Details', onTap: () {}),
        _buildNavTile(title: 'Manage Company Details', onTap: () {}),
        _buildNavTile(title: 'Manage Party Fields', onTap: () {}),
        _buildNavTile(title: 'Manage Item Column', onTap: () {}),
      ],
    );
  }

  Widget _buildDocumentSettings() {
    return _buildExpansionTileCard(
      title: 'Document Settings',
      children: [
        _buildSwitchTile(title: 'Auto Settle Payment', value: _autoSettlePayment, onChanged: (val) => setState(()=> _autoSettlePayment = val)),
        _buildSwitchTile(title: 'Receive Payment When Creating Invoice', value: _receivePayment, onChanged: (val) => setState(()=> _receivePayment = val)),
        _buildSwitchTile(title: 'Enable Cash Discount', value: _enableCashDiscount, onChanged: (val) => setState(()=> _enableCashDiscount = val)),
        _buildSwitchTile(title: 'Enable Additional Charges', value: _enableAdditionalCharges, onChanged: (val) => setState(()=> _enableAdditionalCharges = val)),
        _buildSwitchTile(title: 'Enable Round off', value: _enableRoundOff, onChanged: (val) => setState(()=> _enableRoundOff = val)),
        _buildSwitchTile(title: 'Auto Generate E-waybill', value: _autoGenerateEwaybill, onChanged: (val) => setState(()=> _autoGenerateEwaybill = val)),
        _buildSwitchTile(title: 'Enable TCS For All Buyers', value: _enableTcs, onChanged: (val) => setState(()=> _enableTcs = val)),
        _buildNavTile(title: 'Prefix Management', onTap: (){}),
      ],
    );
  }

    Widget _buildPdfSettings() {
    return _buildExpansionTileCard(
      title: 'PDF Settings',
      children: [
        _buildSwitchTileWithEdit(title: 'Business Slogan', value: _businessSlogan, onChanged: (val) => setState(()=> _businessSlogan = val)),
        _buildSwitchTileWithEdit(title: 'Bottom Slogan', value: _bottomSlogan, onChanged: (val) => setState(()=> _bottomSlogan = val)),
        _buildSwitchTileWithEdit(title: 'Document Header', value: _documentHeader, onChanged: (val) => setState(()=> _documentHeader = val)),
        _buildSwitchTileWithEdit(title: 'Original / Duplicate / Triplicate', value: _originalDuplicate, onChanged: (val) => setState(()=> _originalDuplicate = val)),
        _buildSwitchTileWithEdit(title: 'Watermark', value: _watermark, onChanged: (val) => setState(()=> _watermark = val)),
      ],
    );
  }

  Widget _buildResetButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.refresh, color: Colors.red),
      label: const Text('Reset to default', style: TextStyle(color: Colors.red)),
    );
  }

  Widget _buildSwitchTile({
    String? title,
    IconData? icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: icon != null ? Icon(icon) : null,
      title: Text(title ?? ''),
      value: value,
      onChanged: onChanged,
    );
  }

    Widget _buildSwitchTileWithEdit({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Row(
        children: [
          Text(title),
          const SizedBox(width: 4),
          Icon(Icons.edit, size: 16, color: Theme.of(context).primaryColor),
        ],
      ),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildNavTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

