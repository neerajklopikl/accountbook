import 'package:flutter/material.dart';

class QuotationFiltersScreen extends StatefulWidget {
  const QuotationFiltersScreen({super.key});

  @override
  State<QuotationFiltersScreen> createState() => _QuotationFiltersScreenState();
}

class _QuotationFiltersScreenState extends State<QuotationFiltersScreen> {
  // State variables to hold selected filter values
  String _sortBy = 'date_latest';
  String _filterByDate = 'all_time';
  String _filterByStatus = 'all';

  void _applyAndPop() {
    // Here you would typically pass the selected filter values back
    // to the QuotationListScreen to apply them.
    Navigator.pop(context);
  }

  void _clearAll() {
    setState(() {
      _sortBy = 'date_latest';
      _filterByDate = 'all_time';
      _filterByStatus = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sort & Filters'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: _applyAndPop,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sort by section
              Text('Sort by', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              _buildSortBySection(),
              const Divider(height: 32),

              // Filter by date section
              Text('Filter by date', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              _buildFilterByDateSection(),
              const Divider(height: 32),

              // Filter by status section
              Text('Filter by', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              _buildFilterByStatusSection(),
              const SizedBox(height: 40),

              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSortBySection() {
    return Column(
      children: [
        _buildRadioTile<String>(
          title: 'Quotation Date (Latest First)',
          value: 'date_latest',
          groupValue: _sortBy,
          onChanged: (value) => setState(() => _sortBy = value!),
        ),
        _buildRadioTile<String>(
          title: 'Quotation Date (Oldest First)',
          value: 'date_oldest',
          groupValue: _sortBy,
          onChanged: (value) => setState(() => _sortBy = value!),
        ),
        _buildRadioTile<String>(
          title: 'Quotation Amount (Low to High)',
          value: 'amount_low_high',
          groupValue: _sortBy,
          onChanged: (value) => setState(() => _sortBy = value!),
        ),
        _buildRadioTile<String>(
          title: 'Quotation Amount (High to Low)',
          value: 'amount_high_low',
          groupValue: _sortBy,
          onChanged: (value) => setState(() => _sortBy = value!),
        ),
      ],
    );
  }

  Widget _buildFilterByDateSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildRadioTile<String>(title: 'This Month', value: 'this_month', groupValue: _filterByDate, onChanged: (val) => setState(() => _filterByDate = val!))),
            Expanded(child: _buildRadioTile<String>(title: 'Last Month', value: 'last_month', groupValue: _filterByDate, onChanged: (val) => setState(() => _filterByDate = val!))),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildRadioTile<String>(title: 'Financial Year (2025-2026)', value: 'fy_25_26', groupValue: _filterByDate, onChanged: (val) => setState(() => _filterByDate = val!))),
            Expanded(child: _buildRadioTile<String>(title: 'Last Financial Year (2024-2025)', value: 'fy_24_25', groupValue: _filterByDate, onChanged: (val) => setState(() => _filterByDate = val!))),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildRadioTile<String>(title: 'Custom Date', value: 'custom', groupValue: _filterByDate, onChanged: (val) => setState(() => _filterByDate = val!))),
            Expanded(child: _buildRadioTile<String>(title: 'All Time', value: 'all_time', groupValue: _filterByDate, onChanged: (val) => setState(() => _filterByDate = val!))),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterByStatusSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildRadioTile<String>(title: 'All', value: 'all', groupValue: _filterByStatus, onChanged: (val) => setState(() => _filterByStatus = val!))),
            Expanded(child: _buildRadioTile<String>(title: 'Pending', value: 'pending', groupValue: _filterByStatus, onChanged: (val) => setState(() => _filterByStatus = val!))),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildRadioTile<String>(title: 'Cancelled', value: 'cancelled', groupValue: _filterByStatus, onChanged: (val) => setState(() => _filterByStatus = val!))),
            Expanded(child: _buildRadioTile<String>(title: 'Accepted', value: 'accepted', groupValue: _filterByStatus, onChanged: (val) => setState(() => _filterByStatus = val!))),
          ],
        ),
      ],
    );
  }
  
  Widget _buildRadioTile<T>({required String title, required T value, required T groupValue, required ValueChanged<T?> onChanged}) {
    return RadioListTile<T>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _clearAll,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.grey.shade400),
            ),
            child: const Text('Clear all', style: TextStyle(color: Colors.black)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _applyAndPop,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Apply'),
          ),
        ),
      ],
    );
  }
}