import 'package:flutter/material.dart';

import '../../../models/index.dart';
import './button_container.dart';

class InvitationTile extends StatelessWidget {
  const InvitationTile(this.invitation,
      {required this.onRemoveInvitation, super.key});
  final Invitation invitation;
  final void Function(Invitation invitation) onRemoveInvitation;

  void onAcceptInvite() {
    //TODO: Add workspace to this user

    //TODO: Remove invitation from the list
    onRemoveInvitation(invitation);
  }

  void onIgnoreInvite() {
    //TODO: Remove invitation from the list
    onRemoveInvitation(invitation);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(invitation.workspace.name),
                  Text(
                    'Invited by ${invitation.creator.fullName}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
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
            Text(
              '${invitation.createdAt.day}/${invitation.createdAt.month}/${invitation.createdAt.year}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
