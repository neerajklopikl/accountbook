import 'package:flutter/material.dart';
import 'item_settings_screen.dart';
import 'add_new_unit_screen.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  String? _selectedUnit;
  String _selectedTaxOption = 'Without Tax';

  final List<String> _units = [
    'BAGS (Bag)',
    'BOTTLES (Btl)',
    'BOX (Box)',
    'BUNDLES (Bdl)',
    'CANS (Can)',
    'DOZENS (Dzn)',
    'GRAMMES (Gm)',
    'KILOGRAMS (Kg)',
    'LITRE (Ltr)',
    'METERS (Mtr)',
    'MILILITRE (Ml)',
    'NUMBERS (Nos)',
    'PACKS (Pac)',
    'PAIRS (Prs)',
    'PIECES (Pcs)',
    'QUINTAL (Qtl)',
    'ROLLS (Rol)',
    'SQUARE FEET (Sqf)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/itemSettings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Item Name',
                hintText: 'e.g. Chocolate Cake',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedUnit,
                    items: [
                      ..._units.map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          )),
                           const DropdownMenuItem<String>(
                             value: 'add_new',
                             child: Text(
                              'Add New Unit',
                              style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                       if (value == 'add_new') {
                        showDialog(
                          context: context,
                          builder: (context) => const AddNewUnitScreen(),
                        );
                      } else {
                      setState(() {
                        _selectedUnit = value;
                      });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Rate (Price/Unit)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedTaxOption,
                    items: ['With Tax', 'Without Tax']
                        .map((option) => DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTaxOption = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Save & New functionality
                  },
                  child: const Text('Save & New'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Save functionality
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}