import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreatePaymentReceiptScreen extends StatefulWidget {
  const CreatePaymentReceiptScreen({super.key});

  @override
  State<CreatePaymentReceiptScreen> createState() => _CreatePaymentReceiptScreenState();
}

class _CreatePaymentReceiptScreenState extends State<CreatePaymentReceiptScreen> {
  DateTime _receiptDate = DateTime(2025, 10, 7);
  String _receiptNumber = '1';
  String _receiptPrefix = 'PR';
  int _selectedPaymentMode = 0;

  Future<void> _showVoucherDetails() async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setDialogState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Voucher Details'),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context))
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          value: _receiptPrefix,
                          items: ['PR', 'No Prefix', '+ Add Prefix']
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) {
                            if (val == '+ Add Prefix') {
                              // Handle add prefix logic
                            } else {
                              setDialogState(() {
                                _receiptPrefix = val!;
                              });
                            }
                          },
                          decoration:
                              const InputDecoration(labelText: 'Receipt Number'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          initialValue: _receiptNumber,
                          onChanged: (val) => _receiptNumber = val,
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: DateFormat('dd-MM-yyyy').format(_receiptDate)),
                    decoration: InputDecoration(
                        labelText: 'Receipt Date',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: _receiptDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setDialogState(() {
                                _receiptDate = picked;
                              });
                            }
                          },
                        )),
                  )
                ],
              ),
              actions: [
                TextButton(onPressed: ()=> Navigator.pop(context), child: const Text("CANCEL")),
                ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text("SAVE"))
              ],
            );
          });
        });
    setState(() {}); // Update the main screen after dialog is closed
  }

  void _showAddNotesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Add Notes/Remark'),
            IconButton(icon: const Icon(Icons.close), onPressed: ()=> Navigator.pop(context))
          ],
        ),
        content: const TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Notes/Remark',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [ElevatedButton(onPressed: ()=> Navigator.pop(context), child: const Text('Save'), style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 40)),)],
      ),
    );
  }

    void _showAddPaymentModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Payment Mode'),
        content: const TextField(
          decoration: InputDecoration(
            labelText: 'Enter Payment Mode Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 40)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure you want to go back?'),
        content: const Text('All entered data will be cleared'),
        actions: <Widget>[
           ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, elevation: 0),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          ElevatedButton(
             style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    final paymentModes = ['Cash', 'Cheque', 'Net Banking', 'UPI'];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Custom Header
              InkWell(
                onTap: _showVoucherDetails,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.amber.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$_receiptPrefix$_receiptNumber', style: Theme.of(context).textTheme.titleMedium),
                      Row(
                        children: [
                          Text(DateFormat('dd-MM-yyyy').format(_receiptDate), style: Theme.of(context).textTheme.titleMedium),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Form Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Buyer Details', style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Select Buyer'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.grey))),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Amount Collected',
                          prefixText: '₹ ',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),

                      // Payment Mode Chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(paymentModes.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text(paymentModes[index]),
                                  selected: _selectedPaymentMode == index,
                                  onSelected: (selected) {
                                    if(selected) {
                                      setState(() => _selectedPaymentMode = index);
                                    }
                                  },
                                ),
                              );
                            }),
                             ActionChip(
                              avatar: const Icon(Icons.add),
                              label: const Text('Add Payment Mode'),
                              onPressed: _showAddPaymentModeDialog,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Account',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'add_new',
                            child: Row(
                              children: [
                                Icon(Icons.add_circle_outline, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Add Bank Account'),
                              ],
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value == 'add_new') {
                             Navigator.pushNamed(context, '/addBankAccount');
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                       Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: _showAddNotesDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Notes/Remarks'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
