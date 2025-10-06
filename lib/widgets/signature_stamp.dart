import 'package:flutter/material.dart';

class SignatureAndStamp extends StatelessWidget {
  const SignatureAndStamp({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Signature and Stamp',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOption(
                  context,
                  icon: Icons.edit,
                  label: 'Add Signature',
                  onTap: () {
                    // TODO: Implement add signature functionality
                  },
                ),
                _buildOption(
                  context,
                  icon: Icons.branding_watermark,
                  label: 'Add Stamp',
                  onTap: () {
                    // TODO: Implement add stamp functionality
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(BuildContext context,
      {required IconData icon, required String label, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}