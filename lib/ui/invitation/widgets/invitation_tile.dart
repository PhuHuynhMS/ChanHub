import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import './button_container.dart';

class InvitationTile extends StatelessWidget {
  const InvitationTile(
    this.invitation, {
    required this.onRemoveInvitation,
    super.key,
  });

  final Invitation invitation;
  final void Function(Invitation invitation) onRemoveInvitation;

  void onAcceptInvite() {
    //TODO: Add workspace to this user

    onRemoveInvitation(invitation);
  }

  void onIgnoreInvite() {
    onRemoveInvitation(invitation);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Workspace image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                invitation.workspace.imageUrl,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(width: 20.0),

            // Invitation details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    invitation.workspace.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Invited by ${invitation.creator.fullname}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 10.0),
                  ButtonContainer(
                    invitation: invitation,
                    onIgnoreInvite: onIgnoreInvite,
                    onAcceptInvite: onAcceptInvite,
                  )
                ],
              ),
            ),

            // Created at
            Text(
              formatDateTime(invitation.createdAt),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
