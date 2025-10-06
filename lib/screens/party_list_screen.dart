import 'package:flutter/material.dart';

class PartyListScreen extends StatelessWidget {
  const PartyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Party'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addParty');
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Placeholder
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Party ${index + 1}'),
            onTap: () {
              // TODO: Return selected party
            },
          );
        },
      ),
    );
  }
}
