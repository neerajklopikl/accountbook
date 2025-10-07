import 'package:flutter/material.dart';

class GstReportsScreen extends StatelessWidget {
  const GstReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GST Reports'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildReportItem(context, 'GSTR-1'),
          _buildReportItem(context, 'GSTR-2'),
          _buildReportItem(context, 'GSTR-3B'),
          _buildReportItem(context, 'GST Transaction report'),
          _buildReportItem(context, 'GSTR-9'),
          _buildReportItem(context, 'Sale Summary by HSN'),
          _buildReportItem(context, 'SAC Report'),
        ],
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // TODO: Implement navigation to the specific report screen
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Navigate to $title')),
            );
          },
        ),
        const Divider(height: 1),
      ],
    );
  }
}
