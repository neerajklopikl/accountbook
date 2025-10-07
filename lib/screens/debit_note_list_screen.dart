import 'package:flutter/material.dart';

class DebitNoteListScreen extends StatelessWidget {
  const DebitNoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Debit Notes'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          actions: [
            TextButton.icon(
              onPressed: () {
                 Navigator.pushNamed(context, '/createDebitNote');
              },
              icon: const Icon(Icons.add, color: Colors.black),
              label: const Text('Create New', style: TextStyle(color: Colors.black)),
            )
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 2),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Debit note no. or seller',
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
                const TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Debit Notes'),
                    Tab(text: 'Purchase Return'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildEmptyState(context, 'Debit Note'),
            _buildEmptyState(context, 'Debit Note'),
            _buildEmptyState(context, 'Purchase Return'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String type) {
    return InkWell(
      onTap: ()=> Navigator.pushNamed(context, '/createDebitNote'),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap here to create your first $type',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text('or'),
            const SizedBox(height: 8),
            const Text(
              'Use Create New button in the top',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
