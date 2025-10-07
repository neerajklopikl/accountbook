// lib/models/gstr9_models.dart

class GSTR9ReportData {
  final String gstin;
  final String legalName;
  final String taxPeriod;
  final double aggregateTurnover;

  final OutwardSupplies outwardSupplies;
  final InwardSupplies inwardSupplies;
  final ITCDetails itcDetails;
  final TaxPaidDetails taxPaidDetails;

  GSTR9ReportData({
    required this.gstin,
    required this.legalName,
    required this.taxPeriod,
    required this.aggregateTurnover,
    required this.outwardSupplies,
    required this.inwardSupplies,
    required this.itcDetails,
    required this.taxPaidDetails,
  });
}

class OutwardSupplies {
  final double b2cTaxableValue;
  final double b2cIntegratedTax;
  final double b2bTaxableValue;
  final double b2bIntegratedTax;

  OutwardSupplies({
    required this.b2cTaxableValue,
    required this.b2cIntegratedTax,
    required this.b2bTaxableValue,
    required this.b2bIntegratedTax,
  });
}

class InwardSupplies {
  final double reverseChargeTaxableValue;
  final double reverseChargeIntegratedTax;

  InwardSupplies({
    required this.reverseChargeTaxableValue,
    required this.reverseChargeIntegratedTax,
  });
}

class ITCDetails {
  final double itcAsPerGSTR3B;
  final double itcAsPerGSTR2A;
  final double itcClaimed;

  ITCDetails({
    required this.itcAsPerGSTR3B,
    required this.itcAsPerGSTR2A,
    required this.itcClaimed,
  });
}

class TaxPaidDetails {
  final double integratedTax;
  final double centralTax;
  final double stateTax;
  final double cess;
  final double interest;
  final double lateFee;

  TaxPaidDetails({
    required this.integratedTax,
    required this.centralTax,
    required this.stateTax,
    required this.cess,
    required this.interest,
    required this.lateFee,
  });
}