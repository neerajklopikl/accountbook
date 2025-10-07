import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePaymentMadeScreen extends StatefulWidget {
  const CreatePaymentMadeScreen({super.key});

  @override
  State<CreatePaymentMadeScreen> createState() => _CreatePaymentMadeScreenState();
}

class _CreatePaymentMadeScreenState extends State<CreatePaymentMadeScreen> {
  DateTime _paymentDate = DateTime(2025, 10, 7);
  String _paymentMode = 'CASH';
  String _treatment = 'AGAINST..';

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Wait, Are you sure you want to go back ?'),
            content: const Text('You will miss all the entered data.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Payment'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.amber.shade100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Payment Date\n${DateFormat('dd-MM-yyyy').format(_paymentDate)}'),
                    const Text('Receipt No\n1'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const TextField(decoration: InputDecoration(labelText: 'Seller Name')),
                    const SizedBox(height: 16),
                    const TextField(
                      decoration: InputDecoration(
                        labelText: 'Total Amount',
                        prefixText: '₹ ',
                      ),
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(text: '0.00'),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _paymentMode,
                            decoration: const InputDecoration(labelText: 'Payment Mode'),
                            items: ['CASH', 'CHEQUE', 'NET BANKING', 'UPI', 'OTHERS']
                                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _paymentMode = val!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                             value: _treatment,
                            decoration: const InputDecoration(labelText: 'Treatment'),
                             items: ['AGAINST..','AGAINST BILL', 'ADVANCE', 'ON ACCOUNT (Round Figure)']
                                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (val) {
                               setState(() {
                                _treatment = val!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                     const TextField(decoration: InputDecoration(labelText: 'Account Type', hintText: 'Select Account Type')),
                     const SizedBox(height: 16),
                     const TextField(decoration: InputDecoration(labelText: 'Remarks', hintText: 'Payment Remarks')),
                     const Divider(height: 32),
                     const Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('Purchase List', style: TextStyle(fontWeight: FontWeight.bold)),
                         Text('₹ 0.00', style: TextStyle(fontWeight: FontWeight.bold)),
                       ],
                     )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
