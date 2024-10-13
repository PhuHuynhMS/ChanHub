import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    super.key,
    required this.invitation,
    required this.onIgnoreInvite,
    required this.onAcceptInvite,
  });

  final Invitation invitation;
  final void Function() onIgnoreInvite;
  final void Function() onAcceptInvite;

  void _handleAcceptInvite(BuildContext context) {
    onAcceptInvite();
    showSuccessSnackBar(
      context: context,
      message: 'Invitation accepted successfully',
    );
  }

  void _handleIgnoreInvite(BuildContext context) async {
    bool isAccepted = await showConfirmDialog(
      context: context,
      title: 'Ignore Invitation',
      content: 'Are you sure you want to ignore this invitation?',
    );

    if (isAccepted) {
      onIgnoreInvite();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => _handleAcceptInvite(context),
          child: const Text('Accept'),
        ),
        const SizedBox(width: 10.0),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.error,
            elevation: 1.0,
          ),
          onPressed: () => _handleIgnoreInvite(context),
          child: const Text('Ignore'),
        ),
      ],
    );
  }
}
