// lib/widgets/balance_card.dart

import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String balance;
  const BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    // UPDATED: New gradient and text styles to match the theme
    return Card(
      elevation: 4, // Make this one pop a bit more
      shadowColor: Theme.of(context).primaryColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [const Color(0xFF0052D4), const Color(0xFF4364F7), const Color(0xFF6FB1FC)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 10),
            Text(
              '₹$balance',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}