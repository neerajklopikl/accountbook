import 'package:flutter/material.dart';

class ExcelOptionsDialog extends StatelessWidget {
  const ExcelOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Excel Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.grid_on),
            title: const Text('Open Excel'),
            onTap: () {
              // TODO: Implement open excel
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share Excel'),
            onTap: () {
              // TODO: Implement share excel
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Export to Excel'),
            onTap: () {
              // TODO: Implement export to excel
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}