// lib/models/gstr3b_models.dart

class GSTR3BReportData {
  final String gstin;
  final String legalName;
  final String taxPeriod;
  final OutwardInwardSupplies outwardInwardSupplies;
  final InterStateSupplies interStateSupplies;
  final EligibleITC eligibleITC;
  final LateFeeInterest lateFeeInterest;

  GSTR3BReportData({
    required this.gstin,
    required this.legalName,
    required this.taxPeriod,
    required this.outwardInwardSupplies,
    required this.interStateSupplies,
    required this.eligibleITC,
    required this.lateFeeInterest,
  });
}

// Model for Table 3.1: Details of Outward Supplies and inward supplies liable to reverse charge
class OutwardInwardSupplies {
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;
  final double cess;

  OutwardInwardSupplies({
    this.taxableValue = 0.0,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
    this.cess = 0.0,
  });
}

// Model for Table 3.2: Details of inter-State supplies made to unregistered persons
class InterStateSupplies {
  final String placeOfSupply;
  final double totalTaxableValue;
  final double amountOfIntegratedTax;

  InterStateSupplies({
    required this.placeOfSupply,
    this.totalTaxableValue = 0.0,
    this.amountOfIntegratedTax = 0.0,
  });
}

// Model for Table 4: Eligible ITC
class EligibleITC {
  final double igst;
  final double cgst;
  final double sgst;
  final double cess;

  EligibleITC({
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
    this.cess = 0.0,
  });
}

// Model for Table 5.1: Interest and Late fee for previous tax period
class LateFeeInterest {
  final double igst;
  final double cgst;
  final double sgst;
  final double cess;

  LateFeeInterest({
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
    this.cess = 0.0,
  });
}
