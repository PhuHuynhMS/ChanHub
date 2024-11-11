import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import './widgets/index.dart';

class InvitationScreen extends StatelessWidget {
  static const String routeName = '/invitation';

  const InvitationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final invitations = context.watch<InvitationsManager>().getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: RefreshIndicator(
        child: invitations.isEmpty
            ? ListView(
                padding: const EdgeInsets.only(top: 40.0),
                children: [
                  Text(
                    'No invitations found',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: invitations.length,
                itemBuilder: (context, index) =>
                    InvitationTile(invitations[index]),
              ),
        onRefresh: () async {
          await context.read<InvitationsManager>().fetchInvitations();
        },
      ),
    );
  }
}
