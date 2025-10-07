// lib/models/gst_transaction_report_model.dart

import 'package:flutter/material.dart';

enum GstTransactionType { sale, purchase }

class GstTransaction {
  final DateTime date;
  final GstTransactionType type;
  final String partyName;
  final String gstType;
  final String invoiceNo;
  final double taxableValue;
  final double igst;
  final double cgst;
  final double sgst;
  final double total;

  GstTransaction({
    required this.date,
    required this.type,
    required this.partyName,
    required this.gstType,
    required this.invoiceNo,
    required this.taxableValue,
    this.igst = 0.0,
    this.cgst = 0.0,
    this.sgst = 0.0,
    required this.total,
  });
}
