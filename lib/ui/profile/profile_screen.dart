import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import './widgets/index.dart';
import '../screens.dart';
import '../../managers/index.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<InvitationsManager>().fetchInvitations();
    super.initState();
  }

  void _viewInvitation(BuildContext context, List<Invitation> invitations) {
    Navigator.of(context).pushNamed(InvitationScreen.routeName, arguments: {
      'invitations': invitations,
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Invitation> invitation =
        context.watch<InvitationsManager>().getAll();

    bool isMyProfile = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Badge.count(
              count: context.watch<InvitationsManager>().count(),
              child: const Icon(Icons.mail),
            ),
            onPressed: () => _viewInvitation(context, invitation),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileHeader(isMyProfile: isMyProfile),
                const SizedBox(height: 20.0),
                ProfileDetails(
                  isMyProfile: isMyProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
