import 'package:flutter/material.dart';

class ItemSettingsScreen extends StatelessWidget {
  const ItemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Settings'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Item'),
            value: true,
            onChanged: (bool value) {},
          ),
          const ListTile(
            title: Text('Item Type'),
            trailing: Text('Products and Services'),
          ),
           SwitchListTile(
            title: const Text('Barcode scanning for items'),
            value: false,
            onChanged: (bool value) {},
          ),
           SwitchListTile(
            title: const Text('Stock maintenance'),
            value: true,
            onChanged: (bool value) {},
          ),
           SwitchListTile(
            title: const Text('Manufacturing'),
            value: false,
            onChanged: (bool value) {},
          ),
           SwitchListTile(
            title: const Text('Item Units'),
            value: true,
            onChanged: (bool value) {},
          ),
            SwitchListTile(
            title: const Text('Default Unit'),
            value: false,
            onChanged: (bool value) {},
          ),
           SwitchListTile(
            title: const Text('Item Category'),
            value: true,
            onChanged: (bool value) {},
          ),
           SwitchListTile(
            title: const Text('Party wise item rate'),
            value: false,
            onChanged: (bool value) {},
          ),
           SwitchListTile(
            title: const Text('Wholesale Price'),
            value: false,
            onChanged: (bool value) {},
          ),
            const ListTile(
            title: Text('Quantity (Upto Decimal places)'),
            trailing: Text('2'),
          ),
           SwitchListTile(
            title: const Text('Item wise tax'),
            value: true,
            onChanged: (bool value) {},
          ),
            SwitchListTile(
            title: const Text('Item wise discount'),
            value: true,
            onChanged: (bool value) {},
          ),
            SwitchListTile(
            title: const Text('Update Sale Price from TXN'),
            value: false,
            onChanged: (bool value) {},
          ),
          const ListTile(
            title: Text('Additional Item Fields'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
            const ListTile(
            title: Text('Item Custom Fields'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
             ListTile(
            title: const Text('Description'),
            trailing: IconButton(icon: const Icon(Icons.edit), onPressed: (){},)
          ),
            SwitchListTile(
            title: const Text('GST'),
            value: true,
            onChanged: (bool value) {},
          ),
             SwitchListTile(
            title: const Text('HSN/SAC Code'),
            value: true,
            onChanged: (bool value) {},
          ),
        ],
      ),
    );
  }
}