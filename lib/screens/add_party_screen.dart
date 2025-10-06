import 'package:flutter/material.dart';

class AddPartyScreen extends StatelessWidget {
  const AddPartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Party'),
      ),
      body: const Center(
        child: Text('Add Party Screen'),
      ),
    );
  }
}
