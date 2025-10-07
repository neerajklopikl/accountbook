import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart'; // Import the new package

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({super.key});

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  bool _showOnCard = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Company'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildBusinessCardCarousel(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProfileCompletion(),
                    const SizedBox(height: 16),
                    const TabBar(
                      tabs: [
                        Tab(text: 'Basic Details'),
                        Tab(text: 'Business Details'),
                      ],
                      labelColor: Colors.black,
                      indicatorColor: Colors.blue,
                    ),
                    SizedBox(
                      // Height is required for TabBarView inside a SingleChildScrollView
                      height: 750,
                      child: TabBarView(
                        children: [
                          _buildBasicDetailsForm(),
                          const Center(child: Text('Business Details - Coming Soon')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBusinessCardCarousel() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBusinessCard(Colors.blue.shade800, 'My Company'),
          _buildBusinessCard(Colors.purple.shade800, 'My Company'),
          _buildBusinessCard(Colors.green.shade800, 'My Company'),
          _buildBusinessCard(Colors.red.shade800, 'My Company'),
        ],
      ),
    );
  }

  Widget _buildBusinessCard(Color color, String companyName) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.business)),
                const SizedBox(width: 12),
                Text(
                  companyName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.share, size: 16),
              label: const Text('Share Card'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  foregroundColor: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCompletion() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.orange.shade700),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                  '67% businessmen saw their business increase after sharing their visiting card'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Text('Profile 16% complete.'),
            const SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: 0.16,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBasicDetailsForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          _buildTextField('Business Name', 'My Company'),
          _buildTextField('GSTIN', ''),
          _buildPhoneField('Phone Number 1', '8384049914'),
          _buildTextField('Phone Number 2', ''),
          _buildTextField('Email ID', ''),
          _buildTextField('Business Address', ''),
          _buildTextField('Pincode', ''),
          _buildTextField('Business Description', ''),
          const SizedBox(height: 24),
          const Align(
              alignment: Alignment.centerLeft, child: Text('Signature')),
          const SizedBox(height: 8),
          // FIX: Replaced the incorrect Container with DottedBorder
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            color: Colors.grey.shade400,
            strokeWidth: 1,
            dashPattern: const [6, 4],
            child: SizedBox(
              height: 148, // Adjusted height to account for border
              width: double.infinity,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.edit_outlined, color: Colors.blue),
                    SizedBox(height: 8),
                    Text('Create your signature here'),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: OutlinedButton(onPressed: (){}, child: const Text('Create'))),
              const SizedBox(width: 16),
              Expanded(child: ElevatedButton(onPressed: (){}, child: const Text('Upload'))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPhoneField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Show on card'),
              Switch(
                value: _showOnCard,
                onChanged: (value) {
                  setState(() {
                    _showOnCard = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}