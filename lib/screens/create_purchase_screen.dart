import 'package:flutter/material.dart';

class CreatePurchaseScreen extends StatefulWidget {
  const CreatePurchaseScreen({super.key});

  @override
  State<CreatePurchaseScreen> createState() => _CreatePurchaseScreenState();
}

class _CreatePurchaseScreenState extends State<CreatePurchaseScreen> {
  bool isTaxInvoice = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Create Purchase', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber.shade100,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: isTaxInvoice,
                        onChanged: (value) {
                          setState(() {
                            isTaxInvoice = value!;
                          });
                        },
                      ),
                      const Text('Tax Invoice'),
                      Radio<bool>(
                        value: false,
                        groupValue: isTaxInvoice,
                        onChanged: (value) {
                          setState(() {
                            isTaxInvoice = value!;
                          });
                        },
                      ),
                      const Text('Bill of Supply'),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '6-10-2025',
                          decoration: const InputDecoration(labelText: 'Purchase Date'),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: '1',
                          decoration: const InputDecoration(labelText: 'Purchase', prefixText: 'Prefix '),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Firm Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Card(
                    child: ListTile(
                      title: const Text('My Company'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.amber),
                        onPressed: () {},
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text('Seller Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                   Card(
                    child: ListTile(
                      leading: const Icon(Icons.person_add, color: Colors.amber),
                      title: const Text('Add Seller'),
                       trailing: IconButton(
                        icon: const Icon(Icons.menu, color: Colors.amber),
                        onPressed: () {},
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Consignee Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  RadioListTile(title: const Text('Show Consignee (Same as above)'), value: 1, groupValue: 1, onChanged: (val){},),
                  RadioListTile(title: const Text('Consignee Not Required'), value: 2, groupValue: 1, onChanged: (val){}),
                  RadioListTile(title: const Text('Add Consignee (If different from above)'), value: 3, groupValue: 1, onChanged: (val){}),

                  const SizedBox(height: 16),
                  const Divider(),
                  const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextButton.icon(onPressed: (){}, icon: const Icon(Icons.add), label: const Text('Add Product')),
                   const Divider(),

                  const SizedBox(height: 16),
                  const Text('Transportation Details (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextButton.icon(onPressed: (){}, icon: const Icon(Icons.add), label: const Text('Add Transportation details')),
                   const Divider(),


                  const SizedBox(height: 16),
                  const Text('Other Details (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                   TextButton.icon(onPressed: (){}, icon: const Icon(Icons.add), label: const Text('Add Other details')),
                  const Divider(),


                  const SizedBox(height: 16),
                  const Text('Bank Details (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  TextFormField(decoration: const InputDecoration(labelText: 'Account Holder Name', border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  TextFormField(decoration: const InputDecoration(labelText: 'Bank Account Number', border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  TextFormField(decoration: const InputDecoration(labelText: 'Bank IFSC', border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  TextFormField(decoration: const InputDecoration(labelText: 'Branch Name', border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  TextFormField(decoration: const InputDecoration(labelText: 'Bank Name', border: OutlineInputBorder())),


                  const SizedBox(height: 16),
                  const Text('Optional Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  CheckboxListTile(title: const Text('Original'), value: false, onChanged: (val){}),
                  CheckboxListTile(title: const Text('Duplicate'), value: false, onChanged: (val){}),
                  CheckboxListTile(title: const Text('Triplicate'), value: false, onChanged: (val){}),

                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: 'This is an electronically generated document',
                    decoration: const InputDecoration(
                      labelText: 'Terms and Conditions',
                      border: OutlineInputBorder()
                    ),
                  ),

                  const SizedBox(height: 16),
                   ListTile(
                    title: const Text('Add Signature (Optional)'),
                    trailing: Switch(value: true, onChanged: (val){}),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
