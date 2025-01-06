import 'package:flutter/material.dart';

class GovernorateDetailsScreen extends StatelessWidget {
  const GovernorateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Details'),
      ),
      body: const Center(
        child: Text('Government Details Screen'),
      ),
    );
  }
}
