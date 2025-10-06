import 'package:flutter/material.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  void _showCreateNewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDialogOption(context, Icons.note_add, 'Create New', () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/createPurchase');
                  }),
                  _buildDialogOption(context, Icons.cloud_upload, 'Upload Bill', () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/uploadBill');
                  }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDialogOption(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.amber.shade100,
            child: Icon(icon, size: 30, color: Colors.amber.shade800),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text('Purchases', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            TextButton.icon(
              onPressed: () => _showCreateNewDialog(context),
              icon: const Icon(Icons.edit_outlined, color: Colors.black),
              label: const Text(
                'Create New',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: const TabBar(
                    labelColor: Colors.blue,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'All'),
                      Tab(text: 'Purchases'),
                      Tab(text: 'Uploaded Bills'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildEmptyState(context),
            _buildEmptyState(context),
            _buildEmptyState(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _showCreateNewDialog(context),
            child: const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Tap here', 
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                  TextSpan(
                    text: ' to create your first\\nPurchase Invoice/Upload Bill',
                    style: TextStyle(fontSize: 16)
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          const Text('or', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          const Text.rich(
            TextSpan(
              children: [
                 TextSpan(
                    text: 'Use ',
                    style: TextStyle(fontSize: 16)
                  ),
                  TextSpan(
                    text: 'Create New',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                  ),
                   TextSpan(
                    text: ' button in the\\ntop',
                    style: TextStyle(fontSize: 16)
                  ),
              ]
            ),
             textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
