import 'dart:convert';
import 'package.flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/invoice_model.dart';
import 'create_invoice_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<InvoiceData> _invoices = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchInvoices();
  }

  Future<void> _fetchInvoices() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:5001/api/invoices'));
      if (response.statusCode == 200) {
        final List<dynamic> invoiceList = json.decode(response.body);
        setState(() {
          _invoices = invoiceList.map((json) => InvoiceData.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        // Handle error
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Book'),
        backgroundColor: Colors.amber,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _invoices.isEmpty
              ? _buildEmptyInvoiceView()
              : _buildInvoiceListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateInvoiceScreen()),
          ).then((_) => _fetchInvoices()); // Refetch invoices after creating a new one
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyInvoiceView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Create your first invoice'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateInvoiceScreen()),
              ).then((_) => _fetchInvoices());
            },
            child: const Text('Create Invoice'),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoiceListView() {
    return ListView.builder(
      itemCount: _invoices.length,
      itemBuilder: (context, index) {
        final invoice = _invoices[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(invoice.invoiceNumber),
            subtitle: Text(invoice.buyerName),
            trailing: Text('₹${invoice.totalAmount.toStringAsFixed(2)}'),
            onTap: () {
              // TODO: Implement invoice detail view
            },
          ),
        );
      },
    );
  }
}