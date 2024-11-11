import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class InvitationTile extends StatelessWidget {
  const InvitationTile(
    this.invitation, {
    super.key,
  });

  final Invitation invitation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Workspace image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    invitation.workspace.imageUrl!,
                    fit: BoxFit.cover,
                    width: 45,
                    height: 45,
                  ),
                ),
                const SizedBox(width: 10.0),

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
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
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
            InvitationActions(invitation: invitation)
          ],
        ),
      ),
    );
  }
}
