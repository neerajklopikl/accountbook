// lib/widgets/greeting_header.dart

import 'package:flutter/material.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  const GreetingHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // UPDATED: Cleaner, more modern look
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello,', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600)),
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFFE3F2FD),
          child: Icon(Icons.person, color: Color(0xFF1E88E5)),
        )
      ],
    );
  }
}