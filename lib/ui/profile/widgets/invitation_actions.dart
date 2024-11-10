import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/extensions/index.dart';

class InvitationActions extends StatelessWidget {
  const InvitationActions({
    super.key,
    required this.invitation,
  });

  final Invitation invitation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.error,
            elevation: 1.0,
          ),
          onPressed: () => _onIgnoreInvite(context),
          child: const Text('Ignore'),
        ),
        const SizedBox(width: 10.0),
        TextButton(
          onPressed: () => _onAcceptInvite(context),
          child: const Text('Accept'),
        ),
      ],
    );
  }

  void _onAcceptInvite(BuildContext context) async {
    await context.executeWithErrorHandling(() async {
      await context
          .read<InvitationsManager>()
          .acceptedInvitation(invitation.id);
    });

    if (context.mounted) {
      showSuccessSnackBar(
        context: context,
        message: 'Invitation accepted successfully',
      );
      await context.read<WorkspacesManager>().fetchWorkspaces();
    }
  }

  void _onIgnoreInvite(BuildContext context) async {
    bool isAccepted = await showConfirmDialog(
      context: context,
      title: 'Ignore Invitation',
      content: 'Are you sure you want to ignore this invitation?',
    );

    if (!isAccepted || !context.mounted) {
      return;
    }

    context.executeWithErrorHandling(() async {
      await context.read<InvitationsManager>().ignoredInvitation(invitation.id);
    });
  }
}
