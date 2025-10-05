import 'package:flutter/material.dart';

class PdfOptionsDialog extends StatelessWidget {
  const PdfOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('PDF Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: const Text('Open PDF'),
            onTap: () {
              // TODO: Implement open PDF
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.print),
            title: const Text('Print PDF'),
            onTap: () {
              // TODO: Implement print PDF
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share PDF'),
            onTap: () {
              // TODO: Implement share PDF
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}