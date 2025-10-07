import 'package:flutter/material.dart';

class PaymentReceiptListScreen extends StatefulWidget {
  const PaymentReceiptListScreen({super.key});

  @override
  State<PaymentReceiptListScreen> createState() => _PaymentReceiptListScreenState();
}

class _PaymentReceiptListScreenState extends State<PaymentReceiptListScreen> {
  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const FilterSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Receipt'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
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
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_open_outlined, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            const Text(
              'There are currently no files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('Create New Payment Receipt'),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/createPaymentReceipt');
              },
              icon: const Icon(Icons.add),
              label: const Text('Create New Receipt'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int _selectedCategoryIndex = 0; // 0: Sort by, 1: Date, 2: Payment Mode

  String _sortBy = 'latest';
  String _filterByDate = 'all_time';
  final Set<String> _paymentModes = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: ListView(
                      children: [
                        _buildCategoryItem('Sort by', 0),
                        _buildCategoryItem('Date', 1),
                        _buildCategoryItem('Payment Mode', 2),
                      ],
                    ),
                  ),
                  const VerticalDivider(),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedCategoryIndex,
                      children: [
                        _buildSortByOptions(),
                        _buildDateFilterOptions(),
                        _buildPaymentModeFilterOptions(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                       setState(() {
                        _sortBy = 'latest';
                        _filterByDate = 'all_time';
                        _paymentModes.clear();
                      });
                    },
                    child: const Text('Clear filter'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Apply'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String title, int index) {
    bool isSelected = _selectedCategoryIndex == index;
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      onTap: () => setState(() => _selectedCategoryIndex = index),
      selectedTileColor: Colors.amber.shade100,
    );
  }

  Widget _buildSortByOptions() {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('Latest First'),
          value: 'latest',
          groupValue: _sortBy,
          onChanged: (val) => setState(() => _sortBy = val!),
        ),
        RadioListTile<String>(
          title: const Text('Oldest First'),
          value: 'oldest',
          groupValue: _sortBy,
          onChanged: (val) => setState(() => _sortBy = val!),
        ),
        RadioListTile<String>(
          title: const Text('Amount (High to Low)'),
          value: 'amount_high',
          groupValue: _sortBy,
          onChanged: (val) => setState(() => _sortBy = val!),
        ),
        RadioListTile<String>(
          title: const Text('Amount (Low to High)'),
          value: 'amount_low',
          groupValue: _sortBy,
          onChanged: (val) => setState(() => _sortBy = val!),
        ),
      ],
    );
  }

   Widget _buildDateFilterOptions() {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('All Time'),
          value: 'all_time',
          groupValue: _filterByDate,
          onChanged: (val) => setState(() => _filterByDate = val!),
        ),
        RadioListTile<String>(
          title: const Text('This Month'),
          value: 'this_month',
          groupValue: _filterByDate,
          onChanged: (val) => setState(() => _filterByDate = val!),
        ),
        RadioListTile<String>(
          title: const Text('Last Month'),
          value: 'last_month',
          groupValue: _filterByDate,
          onChanged: (val) => setState(() => _filterByDate = val!),
        ),
        RadioListTile<String>(
          title: const Text('Current FY (2025-2026)'),
          value: 'current_fy',
          groupValue: _filterByDate,
          onChanged: (val) => setState(() => _filterByDate = val!),
        ),
         RadioListTile<String>(
          title: const Text('Last FY (2024-2025)'),
          value: 'last_fy',
          groupValue: _filterByDate,
          onChanged: (val) => setState(() => _filterByDate = val!),
        ),
      ],
    );
  }

  Widget _buildPaymentModeFilterOptions() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Cash'),
          value: _paymentModes.contains('cash'),
          onChanged: (val) => setState(() => val! ? _paymentModes.add('cash') : _paymentModes.remove('cash')),
        ),
        CheckboxListTile(
          title: const Text('Cheque'),
          value: _paymentModes.contains('cheque'),
          onChanged: (val) => setState(() => val! ? _paymentModes.add('cheque') : _paymentModes.remove('cheque')),
        ),
         CheckboxListTile(
          title: const Text('Net Banking'),
          value: _paymentModes.contains('net_banking'),
          onChanged: (val) => setState(() => val! ? _paymentModes.add('net_banking') : _paymentModes.remove('net_banking')),
        ),
        CheckboxListTile(
          title: const Text('UPI'),
          value: _paymentModes.contains('upi'),
          onChanged: (val) => setState(() => val! ? _paymentModes.add('upi') : _paymentModes.remove('upi')),
        ),
      ],
    );
  }
}
