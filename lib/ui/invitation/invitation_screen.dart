import 'package:flutter/material.dart';

import '../../models/index.dart';
import './widgets/index.dart';

class InvitationScreen extends StatefulWidget {
  static const String routeName = '/invitation';

  const InvitationScreen({super.key, required this.invitations});
  final List<Invitation> invitations;
  @override
  State<InvitationScreen> createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  void _removeInvitation(Invitation invitation) {
    widget.invitations.remove(invitation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: widget.invitations.isEmpty
          ? const Center(
              child: Text('No invitations found'),
            )
          : ListView.builder(
              itemBuilder: (context, index) => InvitationTile(
                widget.invitations[index],
                onRemoveInvitation: _removeInvitation,
              ),
              itemCount: widget.invitations.length,
            ),
    );
  }
}
