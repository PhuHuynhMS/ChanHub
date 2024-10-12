import 'package:flutter/material.dart';

import '../../models/index.dart';
import './invitations_manager.dart';
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
    setState(() {
      invitations.remove(invitation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: InvitationList(
          invitations: invitations,
          onRemoveInvitation: _removeInvitation,
        ),
      ),
    );
  }
}

class InvitationList extends StatelessWidget {
  const InvitationList(
      {super.key, required this.invitations, required this.onRemoveInvitation});
  final void Function(Invitation invitation) onRemoveInvitation;
  final List<Invitation> invitations;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => InvitationTile(
                    invitations[index],
                    onRemoveInvitation: onRemoveInvitation),
                itemCount: invitations.length))
      ],
    );
  }
}
