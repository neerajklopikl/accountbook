import 'package:flutter/material.dart';

class DeliveryChallanScreen extends StatefulWidget {
  const DeliveryChallanScreen({super.key});

  @override
  State<DeliveryChallanScreen> createState() => _DeliveryChallanScreenState();
}

class _DeliveryChallanScreenState extends State<DeliveryChallanScreen> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showChangeChallanNoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Challan No.'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Invoice Prefix'),
              Row(
                children: [
                  ChoiceChip(label: const Text('None'), selected: true, onSelected: (val){}),
                  const SizedBox(width: 8),
                  ChoiceChip(label: const Text('Add Prefix'), selected: false, onSelected: (val){}),
                ],
              ),
              TextFormField(
                initialValue: '1',
                decoration: const InputDecoration(
                  labelText: 'Challan No.',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Challan'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _showChangeChallanNoDialog,
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Challan No.'),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('1'), Icon(Icons.arrow_drop_down)],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Date'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Customer Name *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Due Date',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today), 
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Items (Optional)'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Total Amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextFormField(
              textAlign: TextAlign.right,
              decoration: const InputDecoration(
                hintText: '₹',
                border: InputBorder.none
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Save & New')),
            ElevatedButton(onPressed: () {}, child: const Text('Save')),
            IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
