import 'package:flutter/material.dart';

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
  void _viewInvitation(BuildContext context) {
    Navigator.of(context).pushNamed(InvitationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    bool isMyProfile = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Badge.count(
              count: InvitationsManager().count(),
              child: const Icon(Icons.mail),
            ),
            onPressed: () => _viewInvitation(context),
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
