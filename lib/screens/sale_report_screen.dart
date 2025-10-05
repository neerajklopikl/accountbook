import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleReportScreen extends StatefulWidget {
  const SaleReportScreen({super.key});

  @override
  State<SaleReportScreen> createState() => _SaleReportScreenState();
}

class _SaleReportScreenState extends State<SaleReportScreen> {
  String _selectedFilter = 'This Month';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        _selectedFilter = 'Custom';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Report'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
         actions: [
          IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PDF clicked!')),
            );
          }),
          IconButton(icon: const Icon(Icons.grid_on), onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Grid clicked!')),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                   items: <String>['This Month', 'Today', 'This Week', 'This Quarter', 'This Financial Year', 'Custom']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(onPressed: ()=> _selectDate(context, true), child: Text(DateFormat('dd/MM/yy').format(_startDate))),
                    const Text('TO'),
                    TextButton(onPressed: ()=> _selectDate(context, false), child: Text(DateFormat('dd/MM/yy').format(_endDate))),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Filters clicked!')),
                    );
                  },
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filters'),
                ),
              ],
            ),
          ),
          // Summary Cards
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                 Expanded(child: SummaryCard(title: 'No of Txns', value: '1')),
                 SizedBox(width: 8),
                 Expanded(child: SummaryCard(title: 'Total Sale', value: '₹ 75.00')),
                 SizedBox(width: 8),
                 Expanded(child: SummaryCard(title: 'Balance Due', value: '₹ 25.00', valueColor: Colors.red)),
              ],
            ),
          ),
          const Divider(),
          // Transaction List
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Lilawati'),
                  subtitle: const Text('SALE 1 | 03 OCT, 25'),
                  trailing: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Amount: ₹ 75.00'),
                      Text('Balance: ₹ 25.00'),
                    ],
                  ),
                   onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lilawati sale clicked!')),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: valueColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}