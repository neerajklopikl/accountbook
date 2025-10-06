import 'package:flutter/material.dart';

class TransportDetailsScreen extends StatefulWidget {
  const TransportDetailsScreen({super.key});

  @override
  State<TransportDetailsScreen> createState() => _TransportDetailsScreenState();
}

class _TransportDetailsScreenState extends State<TransportDetailsScreen> {
  DateTime? _lrDate;
  DateTime? _supplyDate;

  Future<void> _selectDate(BuildContext context, {bool isLRDate = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.amber, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.amber, // button text color
              ),
            ),
          ),
          child: child!,
        );
      }
    );
    if (picked != null) {
      setState(() {
        if (isLRDate) {
          _lrDate = picked;
        } else {
          _supplyDate = picked;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transport Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Select Transportation Mode', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Mode of Transport'),
                      items: const [DropdownMenuItem(value: 'Road', child: Text('Road'))],
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 16),
                    const Text('More Details', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(decoration: const InputDecoration(labelText: 'LR Number')),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'LR Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context, isLRDate: true),
                        ),
                      ),
                      controller: TextEditingController(text: _lrDate == null ? '' : '${_lrDate!.day}/${_lrDate!.month}/${_lrDate!.year}'),
                    ),
                    TextFormField(decoration: const InputDecoration(labelText: 'Vehicle Number')),
                    TextFormField(decoration: const InputDecoration(labelText: 'Approx Distance in KMS')),
                    const SizedBox(height: 16),
                    const Text('Transporter Details', style: TextStyle(fontWeight: FontWeight.bold)),
                    ListTile(
                      leading: const Icon(Icons.menu),
                      title: const Text('Select Transporter ID'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 16),
             Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Supplier Details', style: TextStyle(fontWeight: FontWeight.bold)),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Place of supply'),
                      items: const [DropdownMenuItem(value: 'State', child: Text('State'))],
                      onChanged: (value) {},
                    ),
                    TextFormField(
                       readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date of supply',
                         suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                       controller: TextEditingController(text: _supplyDate == null ? '' : '${_supplyDate!.day}/${_supplyDate!.month}/${_supplyDate!.year}'),
                    ),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Supply Type'),
                      items: const [DropdownMenuItem(value: 'Type', child: Text('Type'))],
                      onChanged: (value) {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, padding: const EdgeInsets.symmetric(vertical: 16)),
          child: const Text('Save', style: TextStyle(fontSize: 18, color: Colors.black)),
        ),
      ),
    );
  }
}
