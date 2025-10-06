import 'package:flutter/material.dart';

class UploadBillScreen extends StatelessWidget {
  const UploadBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Upload Bill', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: '1',
              decoration: const InputDecoration(
                labelText: 'Purchase Invoice No.',
                 border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: '6-10-2025',
              decoration: const InputDecoration(
                labelText: 'Purchase Date',
                 border: UnderlineInputBorder(),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 24),
            const Text('Seller Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.amber),
              title: const Text('Add Seller'),
              trailing: const Icon(Icons.menu),
              onTap: () {},
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 24),
            const Text('Upload Bills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(child: Icon(Icons.add, size: 40, color: Colors.grey,)),
            )
          ],
        ),
      ),
    );
  }
}
