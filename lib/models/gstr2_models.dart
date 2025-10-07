// lib/models/gstr2_models.dart

class GSTR2ReportData {
  final String gstin;
  final String legalName;
  final String taxPeriod;
  final List<B2BPurchase> b2bPurchases;
  final List<PurchaseCreditDebitNote> creditDebitNotes;
  final List<HSNInwardSummary> hsnSummary;

  GSTR2ReportData({
    required this.gstin,
    required this.legalName,
    required this.taxPeriod,
    this.b2bPurchases = const [],
    this.creditDebitNotes = const [],
    this.hsnSummary = const [],
  });
}

// Model for Table 3: Inward supplies received from a registered person
class B2BPurchase {
  final String supplierGstin;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final double invoiceValue;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  B2BPurchase({
    required this.supplierGstin,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.invoiceValue,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}

// Model for Table 6: Credit/Debit Notes received
class PurchaseCreditDebitNote {
  final String supplierGstin;
  final String noteNumber;
  final DateTime noteDate;
  final double noteValue;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  PurchaseCreditDebitNote({
    required this.supplierGstin,
    required this.noteNumber,
    required this.noteDate,
    required this.noteValue,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}

// Model for Table 13: HSN summary of inward supplies
class HSNInwardSummary {
  final String hsn;
  final String description;
  final String uqc;
  final double totalQuantity;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  HSNInwardSummary({
    required this.hsn,
    required this.description,
    required this.uqc,
    required this.totalQuantity,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}