import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Company...'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildMyBusinessSection(context),
          _buildCashAndBankSection(context),
          _buildImportantUtilitiesSection(context),
          _buildOthersSection(context),
          _buildAppVersion(context),
        ],
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMyBusinessSection(BuildContext context) {
    return _buildCard(
      children: [
        const ExpansionTile(
          leading: Icon(Icons.point_of_sale),
          title: Text('Sale'),
          children: <Widget>[
            // Add sub-items for Sale here if any
          ],
        ),
        const ExpansionTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Purchase'),
          children: <Widget>[
            // Add sub-items for Purchase here if any
          ],
        ),
        ListTile(
          leading: const Icon(Icons.receipt_long),
          title: const Text('Expenses'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.storefront),
          title: const Text('My Online Store'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: const Text('Reports'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildCashAndBankSection(BuildContext context) {
    return _buildCard(
      children: [
        ListTile(
          leading: const Icon(Icons.account_balance),
          title: const Text('Bank Accounts'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.money),
          title: const Text('Cash In-Hand'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: const Text('Cheques'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.pie_chart),
          title: const Text('Loan Accounts'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildImportantUtilitiesSection(BuildContext context) {
    return _buildCard(
      children: [
        ListTile(
          leading: const Icon(Icons.sync),
          title: const Text('Sync & Share'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.layers),
          title: const Text('Bulk Update Tax Slab'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.business),
          title: const Text('Manage Companies'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const ExpansionTile(
          leading: Icon(Icons.restore),
          title: Text('Backup/Restore'),
          children: <Widget>[],
        ),
        ExpansionTile(
          leading: const Icon(Icons.build),
          title: Row(
            children: [
              const Text('Utilities'),
              const SizedBox(width: 8),
              Chip(
                label: const Text('New', style: TextStyle(color: Colors.white, fontSize: 10)),
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          children: const <Widget>[],
        ),
      ],
    );
  }

  Widget _buildOthersSection(BuildContext context) {
    return _buildCard(
      children: [
        ListTile(
          leading: const Icon(Icons.local_offer, color: Colors.red),
          title: const Text('Plans & Pricing'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.desktop_windows, color: Colors.blue),
          title: const Text('Get Desktop Billing Software'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
        const ExpansionTile(
          leading: Icon(Icons.chat, color: Colors.green),
          title: Text('Grow Your Business'),
          children: <Widget>[],
        ),
        ListTile(
          leading: const Icon(Icons.settings, color: Colors.grey),
          title: Row(
            children: [
              const Text('Settings'),
              const SizedBox(width: 8),
              Chip(
                label: const Text('New', style: TextStyle(color: Colors.white, fontSize: 10)),
                backgroundColor: Colors.red,
                padding: const EdgeInsets.all(2),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
        const ExpansionTile(
          leading: Icon(Icons.headset_mic, color: Colors.blue),
          title: Text('Help & Support'),
          children: <Widget>[],
        ),
        ListTile(
          leading: const Icon(Icons.star, color: Colors.orange),
          title: const Text('Rate this app'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildAppVersion(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('App Version'),
              Text('20.9.4'),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              child: const Text('Privacy Policy'),
            ),
          ),
        ],
      ),
    );
  }
}