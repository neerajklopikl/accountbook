// lib/screens/e_invoice_login_screen.dart

import 'package:flutter/material.dart';

class EInvoiceLoginScreen extends StatelessWidget {
  const EInvoiceLoginScreen({super.key});

  void _showHelpOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Get help from AccountBook',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text('Call Us'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement call functionality
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('WhatsApp Us'),
            onTap: () {
              Navigator.pop(context);
              // TODO: Implement WhatsApp functionality
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Invoice Login'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Turnover above Rs.5Cr?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Start E-Invoicing to avoid the penalties. Login with your eWay bill credentials to start using E-Invoices with AccountBook',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Text(
                        'E-Invoice System Login',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'GSTIN',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          textStyle: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Login'),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton.icon(
                        onPressed: () => _showHelpOptions(context),
                        icon: const Icon(Icons.call),
                        label: const Text('Call Us for any help'),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _buildInfoSection(
                context,
                'Why E-Invoicing with AccountBook?',
                [
                  _buildFeatureItem(Icons.bolt, 'Create E-Invoice in 1 sec'),
                  _buildFeatureItem(Icons.all_inclusive, 'Unlimited E-Invoice Credits'),
                  _buildFeatureItem(Icons.edit, 'Easy Edit'),
                  _buildFeatureItem(Icons.sync, 'Easy Connect with E-Invoice & E-Way Bill'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber.shade800),
        title: Text(text),
      ),
    );
  }
}