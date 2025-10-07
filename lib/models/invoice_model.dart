// lib/models/invoice_model.dart

class InvoiceItem {
  final int srNo;
  final String name;
  final String? hsnSac;
  final int quantity;
  final String unit;
  final double rate;
  final double discount;
  final double taxableValue;
  final double igstRate;
  final double igstAmount;
  final double total;

  InvoiceItem({
    required this.srNo,
    required this.name,
    this.hsnSac,
    required this.quantity,
    required this.unit,
    required this.rate,
    required this.discount,
    required this.taxableValue,
    required this.igstRate,
    required this.igstAmount,
    required this.total,
  });
}

class InvoiceData {
  // Company Details
  final String companyName;
  final String companyAddress;
  final String companyGstin;

  // Invoice Details
  final String invoiceNumber;
  final DateTime invoiceDate;
  final String poNumber;
  final String transporterName;
  final String ewayBillNumber;

  // Party Details
  final String dispatchFrom;
  final String buyerName;
  final String buyerAddress;
  final String buyerGstin;

  // Items
  final List<InvoiceItem> items;
  
  // Totals
  final double totalAmount;
  final String totalAmountInWords;

  // Bank Details
  final String bankAccountNo;
  final String bankIfsc;
  final String bankName;
  final String upiId;

  // Terms
  final List<String> termsAndConditions;

  InvoiceData({
    required this.companyName,
    required this.companyAddress,
    required this.companyGstin,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.poNumber,
    required this.transporterName,
    required this.ewayBillNumber,
    required this.dispatchFrom,
    required this.buyerName,
    required this.buyerAddress,
    required this.buyerGstin,
    required this.items,
    required this.totalAmount,
    required this.totalAmountInWords,
    required this.bankAccountNo,
    required this.bankIfsc,
    required this.bankName,
    required this.upiId,
    required this.termsAndConditions,
  });
}