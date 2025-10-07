// lib/models/gstr1_models.dart

// Main data model for the entire GSTR-1 report
class GSTR1ReportData {
  final String gstin;
  final String legalName;
  final double aggregateTurnover;
  final String taxPeriod;
  final List<B2BInvoice> b2bInvoices;
  final List<B2CSummary> b2cSmallSummary;
  final List<CreditDebitNote> creditDebitNotesRegistered;
  final List<HSNSummary> hsnSummary;
  final DocumentSummary documentSummary;

  GSTR1ReportData({
    required this.gstin,
    required this.legalName,
    required this.aggregateTurnover,
    required this.taxPeriod,
    this.b2bInvoices = const [],
    this.b2cSmallSummary = const [],
    this.creditDebitNotesRegistered = const [],
    this.hsnSummary = const [],
    required this.documentSummary,
  });
}

// Model for Table 4: B2B Invoices
class B2BInvoice {
  final String invoiceNumber;
  final DateTime invoiceDate;
  final String recipientGstin;
  final String recipientName;
  final double invoiceValue;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  B2BInvoice({
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.recipientGstin,
    required this.recipientName,
    required this.invoiceValue,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}

// Model for Table 7: B2C (Others) Summary
class B2CSummary {
  final String placeOfSupply;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  B2CSummary({
    required this.placeOfSupply,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}

// Model for Table 9B: Credit/Debit Notes (Registered)
class CreditDebitNote {
  final String noteNumber;
  final DateTime noteDate;
  final String originalInvoiceNumber;
  final DateTime originalInvoiceDate;
  final double noteValue;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  CreditDebitNote({
    required this.noteNumber,
    required this.noteDate,
    required this.originalInvoiceNumber,
    required this.originalInvoiceDate,
    required this.noteValue,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}

// Model for Table 12: HSN-wise Summary
class HSNSummary {
  final String hsn;
  final String description;
  final String uqc; // Unit Quantity Code
  final double totalQuantity;
  final double totalValue;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;

  HSNSummary({
    required this.hsn,
    required this.description,
    required this.uqc,
    required this.totalQuantity,
    required this.totalValue,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
  });
}

// Model for Table 13: Document Summary
class DocumentSummary {
  final int invoicesForOutwardSupply;
  final int creditNotes;
  final int debitNotes;

  DocumentSummary({
    required this.invoicesForOutwardSupply,
    required this.creditNotes,
    required this.debitNotes,
  });
}
