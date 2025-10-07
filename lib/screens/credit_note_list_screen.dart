import 'package:flutter/material.dart';

class CreditNoteListScreen extends StatelessWidget {
  const CreditNoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Credit Notes'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by Cr.note no. or buyer',
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
                    Tab(text: 'Credit Notes'),
                    Tab(text: 'Sale Return'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildEmptyState(context, 'Credit Note', '/createCreditNote'),
            _buildEmptyState(context, 'Credit Note', '/createCreditNote'),
            _buildEmptyState(context, 'Sales Return', '/createCreditNote'),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String type, String route) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
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