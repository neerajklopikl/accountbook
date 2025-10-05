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
          IconButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit clicked!')),
            );
          }, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications clicked!')),
            );
          }, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/settings');
          }, icon: const Icon(Icons.settings)),
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
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () {
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logout clicked!')),
              );
            },
          ),
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
        ExpansionTile(
          leading: const Icon(Icons.point_of_sale),
          title: const Text('Sale'),
          onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sale clicked!')),
              );
            }
          },
          children: <Widget>[
            // Add sub-items for Sale here if any
          ],
        ),
        ExpansionTile(
          leading: const Icon(Icons.shopping_cart),
          title: const Text('Purchase'),
           onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Purchase clicked!')),
              );
            }
          },
          children: <Widget>[
            // Add sub-items for Purchase here if any
          ],
        ),
        ListTile(
          leading: const Icon(Icons.receipt_long),
          title: const Text('Expenses'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Expenses clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.storefront),
          title: const Text('My Online Store'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('My Online Store clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.bar_chart),
          title: const Text('Reports'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reports clicked!')),
            );
          },
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
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bank Accounts clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.money),
          title: const Text('Cash In-Hand'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cash In-Hand clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.check_box_outline_blank),
          title: const Text('Cheques'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Cheques clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.pie_chart),
          title: const Text('Loan Accounts'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Loan Accounts clicked!')),
            );
          },
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
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sync & Share clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.layers),
          title: const Text('Bulk Update Tax Slab'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bulk Update Tax Slab clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.business),
          title: const Text('Manage Companies'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Manage Companies clicked!')),
            );
          },
        ),
        ExpansionTile(
          leading: const Icon(Icons.restore),
          title: const Text('Backup/Restore'),
           onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Backup/Restore clicked!')),
              );
            }
          },
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
           onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Utilities clicked!')),
              );
            }
          },
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
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Plans & Pricing clicked!')),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.desktop_windows, color: Colors.blue),
          title: const Text('Get Desktop Billing Software'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Get Desktop Billing Software clicked!')),
            );
          },
        ),
        ExpansionTile(
          leading: const Icon(Icons.chat, color: Colors.green),
          title: const Text('Grow Your Business'),
           onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Grow Your Business clicked!')),
              );
            }
          },
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
        ExpansionTile(
          leading: const Icon(Icons.headset_mic, color: Colors.blue),
          title: const Text('Help & Support'),
           onExpansionChanged: (isExpanded) {
            if (isExpanded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help & Support clicked!')),
              );
            }
          },
          children: <Widget>[],
        ),
        ListTile(
          leading: const Icon(Icons.star, color: Colors.orange),
          title: const Text('Rate this app'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Rate this app clicked!')),
            );
          },
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
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy Policy clicked!')),
                );
              },
              child: const Text('Privacy Policy'),
            ),
          ),
        ],
      ),
    );
  }
}