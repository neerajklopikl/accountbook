// lib/models/invoice_model.dart

class InvoiceItem {
  final int srNo;
  final String name;
  final String? hsnSac;
  final double quantity;
  final String unit;
  final double rate;
  final double discount;
  final double taxableValue;
  final double igstRate;
  final double igstAmount;
  final double cgstAmount;
  final double sgstAmount;
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
    required this.cgstAmount,
    required this.sgstAmount,
    required this.total,
  });
}

class InvoiceData {
  final String? id;
  final String companyName;
  final String companyAddress;
  final String companyGstin;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final String poNumber;
  final String transporterName;
  final String ewayBillNumber;
  final String dispatchFrom;
  final String buyerName;
  final String buyerAddress;
  final String buyerGstin;
  final List<InvoiceItem> items;
  final double totalAmount;
  final String totalAmountInWords;
  final String bankAccountNo;
  final String bankIfsc;
  final String bankName;
  final String upiId;
  final List<String> termsAndConditions;

  InvoiceData({
    this.id,
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

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      id: json['_id'],
      invoiceNumber: json['invoiceNumber'],
      buyerName: json['customerName'],
      invoiceDate: DateTime.parse(json['date']),
      totalAmount: json['totalAmount'].toDouble(),
      companyName: '',
      companyAddress: '',
      companyGstin: '',
      poNumber: '',
      transporterName: '',
      ewayBillNumber: '',
      dispatchFrom: '',
      buyerAddress: '',
      buyerGstin: '',
      items: [],
      totalAmountInWords: '',
      bankAccountNo: '',
      bankIfsc: '',
      bankName: '',
      upiId: '',
      termsAndConditions: [],
    );
  }
}