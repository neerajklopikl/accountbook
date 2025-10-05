import 'package:flutter/material.dart';

class ItemSettingsScreen extends StatelessWidget {
  const ItemSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [
          _buildSwitchTile(title: 'Enable Item', value: true, info: true),
          const ListTile(
            title: Text('Item Type'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Products and Services'),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          ),
          _buildSwitchTile(
              title: 'Barcode scanning for items', value: false, info: true),
          _buildSwitchTile(title: 'Stock maintenance', value: true, info: true),
          _buildSwitchTile(
              title: 'Manufacturing', value: false, info: true, premium: true),
          _buildSwitchTile(title: 'Item Units', value: true, info: true),
          _buildSwitchTile(title: 'Default Unit', value: false, info: true),
          _buildSwitchTile(title: 'Item Category', value: true, info: true),
          _buildSwitchTile(
              title: 'Party wise item rate',
              value: false,
              info: true,
              premium: true),
          _buildSwitchTile(
              title: 'Wholesale Price', value: false, info: true, premium: true),
          ListTile(
            title: const Text('Quantity (Upto Decimal places)'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.remove), onPressed: () {}),
                const Text('2'),
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              ],
            ),
          ),
          _buildSwitchTile(title: 'Item wise tax', value: true, info: true),
          _buildSwitchTile(
              title: 'Item wise discount', value: true, info: true),
          _buildSwitchTile(
              title: 'Update Sale Price from TXN', value: false, info: true),
          _buildNavTile(title: 'Additional Item Fields', premium: true),
          _buildNavTile(title: 'Item Custom Fields', premium: true, info: true),
          _buildSwitchTile(title: 'Description', value: false, info: true, hasEdit: true),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('GST', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          _buildSwitchTile(title: 'HSN/SAC Code', value: true),
          _buildSwitchTile(title: 'Additional CESS', value: false, info: true),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    bool info = false,
    bool premium = false,
    bool hasEdit = false,
  }) {
    return SwitchListTile(
      title: Row(
        children: [
          Text(title),
          if (info) const SizedBox(width: 4),
          if (info) const Icon(Icons.info_outline, size: 16, color: Colors.grey),
          if (premium) const SizedBox(width: 4),
          if (premium) const Icon(Icons.workspace_premium_outlined, size: 16, color: Colors.purple),
        ],
      ),
      value: value,
      onChanged: (bool val) {},
      secondary: hasEdit ? IconButton(icon: const Icon(Icons.edit), onPressed: (){},) : null,
    );
  }

  Widget _buildNavTile({required String title, bool premium = false, bool info = false}) {
    return ListTile(
      title: Row(
        children: [
          Text(title),
          if (info) const SizedBox(width: 4),
          if (info) const Icon(Icons.info_outline, size: 16, color: Colors.grey),
          if (premium) const SizedBox(width: 4),
          if (premium) const Icon(Icons.workspace_premium_outlined, size: 16, color: Colors.purple),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}