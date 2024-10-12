import 'package:flutter/material.dart';
import '../../../models/index.dart';

class ButtonContainer extends StatefulWidget {
  const ButtonContainer(
      {super.key,
      required this.invitation,
      required this.onIgnoreInvite,
      required this.onAcceptInvite});

  final Invitation invitation;
  final void Function() onIgnoreInvite;
  final void Function() onAcceptInvite;

  @override
  State<ButtonContainer> createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  void _handleAcceptInvite() {
    widget.onAcceptInvite();
    // them await khi da them xu ly logic trong onAcceptInvite
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Workpace has been added!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _handleIgnoreInvite() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ignore Invitation'),
            content:
                const Text('Are you sure you want to ignore this invitation?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                },
              ),
              TextButton(
                child: const Text('Ignore'),
                onPressed: () async {
                  Navigator.of(context).pop(); // Đóng hộp thoại
                  widget
                      .onIgnoreInvite(); // them await khi da them xu ly logic trong onIgnoreInvite
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            _handleAcceptInvite();
          },
          child: const Text('Accept'),
        ),
        const SizedBox(width: 10.0),
        ElevatedButton(
          onPressed: _handleIgnoreInvite,
          style: ButtonStyle(
              fixedSize: const WidgetStatePropertyAll(Size.fromWidth(100.0)),
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).colorScheme.error)),
          child: const Text('Ignore'),
        ),
      ],
    );
  }
}
