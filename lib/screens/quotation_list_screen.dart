import 'package:flutter/material.dart';

class QuotationListScreen extends StatefulWidget {
  const QuotationListScreen({super.key});

  @override
  State<QuotationListScreen> createState() => _QuotationListScreenState();
}

class _QuotationListScreenState extends State<QuotationListScreen> {
  int _selectedTabIndex = 0; // 0 for "All"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotations'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    Navigator.pushNamed(context, '/quotationFilters');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabs(),
          Expanded(
            child: _buildEmptyState(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildTabButton('All', 0),
            const SizedBox(width: 10),
            _buildTabButton('Pending', 1),
            const SizedBox(width: 10),
            _buildTabButton('Accepted', 2),
            const SizedBox(width: 10),
            _buildTabButton('Cancelled', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return ElevatedButton(
      onPressed: () => setState(() => _selectedTabIndex = index),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _selectedTabIndex == index ? Theme.of(context).primaryColor : Colors.white,
        foregroundColor:
            _selectedTabIndex == index ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24),
      ),
      child: Text(text),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: const Color(0xFFFAF3E0).withOpacity(0.7),
            child: const Icon(Icons.description_outlined,
                size: 50, color: Colors.amber),
          ),
          const SizedBox(height: 24),
          const Text('Create your first Quotation',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Icon(Icons.arrow_downward, color: Colors.amber, size: 40),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/estimateQuote'),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Create Quotation'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}