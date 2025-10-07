// lib/models/invoice_model.dart

import 'package:intl/intl.dart';

// Model for a single item line in the invoice
class InvoiceItem {
  final String description;
  final int quantity;
  final double unitPrice;
  final double taxRate; // e.g., 0.05 for 5%

  InvoiceItem(this.description, this.quantity, this.unitPrice, this.taxRate);
}

// Model for all the data needed to generate an invoice
class InvoiceData {
  final String invoiceNumber;
  final DateTime date;
  final String companyName;
  final String companyAddress;
  final String companyGstin;
  final String buyerName;
  final String buyerAddress;
  final String buyerGstin;
  final List<InvoiceItem> items;

  InvoiceData({
    required this.invoiceNumber,
    required this.date,
    required this.companyName,
    required this.companyAddress,
    required this.companyGstin,
    required this.buyerName,
    required this.buyerAddress,
    required this.buyerGstin,
    required this.items,
  });
}