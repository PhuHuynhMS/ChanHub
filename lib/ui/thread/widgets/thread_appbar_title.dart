import 'package:flutter/material.dart';

class ThreadAppBarTitle extends StatelessWidget {
  const ThreadAppBarTitle(
    this.channelName, {
    super.key,
  });

  final String channelName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('# Thread'),
        Text(
          'Message in $channelName',
          style: Theme.of(context).primaryTextTheme.titleSmall,
        ),
      ],
    );
  }
}
