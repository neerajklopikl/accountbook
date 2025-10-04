import 'package:flutter/material.dart';

enum TransactionType { credit, debit }

class Transaction {
  final String name;
  final String date;
  final double amount;
  final TransactionType type;

  Transaction({
    required this.name,
    required this.date,
    required this.amount,
    required this.type,
  });
}