// lib/screens/invoice_settings_screen.dart

import 'dart.typed_data';

import 'package:accountbook/models/invoice_model.dart';
import 'package:accountbook/screens/pdf_preview_screen.dart';
import 'package:accountbook/services/pdf_generator.dart';
import 'package:accountbook/widgets/add_custom_field_dialog.dart';
import 'package:flutter/material.dart';

class InvoiceSettingsScreen extends StatefulWidget {
  const InvoiceSettingsScreen({super.key});

  @override
  State<InvoiceSettingsScreen> createState() => _InvoiceSettingsScreenState();
}

class _InvoiceSettingsScreenState extends State<InvoiceSettingsScreen> {
  String _selectedTemplate = 'Classic';

  // State variables for switches (you can keep them if needed for other logic)
  bool _bankAndUpi = true;
  // ... other switch variables

  // NEW METHOD TO HANDLE PDF GENERATION AND PREVIEW
  Future<void> _generateAndShowPdf(String template) async {
    setState(() => _selectedTemplate = template);

    // NEW: Create detailed dummy data for the invoice to match the classic format
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
            igstAmount: 342.00, total: 2337.00),
        InvoiceItem(
            srNo: 2, name: 'Rubber Waste', hsnSac: '2901001', quantity: 1, unit: 'TON',
            rate: 500.00, discount: 5.00, taxableValue: 475.00, igstRate: 5.00,
            igstAmount: 23.75, total: 522.50),
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
        // ... add other terms
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
        // Use the new detailed function
        pdfData = await PdfGenerator.generateClassicPdf(dummyData);
        break;
    }
    
    Navigator.of(context).pop();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(pdfData: pdfData),
      ),
    );
  }

  // --- The rest of your build methods for the screen UI remain unchanged ---
  // --- (build, _buildPdfTemplateSelector, _buildPrimarySwitches, etc.) ---
  
  @override
  Widget build(BuildContext context) {
    // ... no changes here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customise Invoice'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildPdfTemplateSelector(),
          // ... all your other widgets
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
  // ... Rest of your UI build methods
}