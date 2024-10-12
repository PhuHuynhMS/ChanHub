import 'package:flutter/material.dart';

class InvitationScreen extends StatelessWidget {
  static const String routeName = '/invitation';

  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitation'),
      ),
      body: const Center(
        child: Text('Invitation Screen'),
      ),
    );
  }
}
