import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../../managers/index.dart';
import './widgets/index.dart';

class InvitationScreen extends StatefulWidget {
  static const String routeName = '/invitation';

  const InvitationScreen({super.key});

  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  List<Invitation> invitations = [];
  @override
  void initState() {
    super.initState();

    //TODO: Get all invitations of the user
    invitations = InvitationsManager().getAll();
  }

  void _removeInvitation(Invitation invitation) {
    invitations.remove(invitation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: invitations.isEmpty
          ? const Center(
              child: Text('No invitations found'),
            )
          : ListView.builder(
              itemBuilder: (context, index) => InvitationTile(
                invitations[index],
                onRemoveInvitation: _removeInvitation,
              ),
              itemCount: invitations.length,
            ),
    );
  }
}
