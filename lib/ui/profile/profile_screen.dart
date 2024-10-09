import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/index.dart';
import './profile_screen_manager.dart';
import '../../models/index.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileScreen({super.key});

//User who is currently logged in
  static User temporaryUser = User(
    id: '1',
    fullName: 'John Doe',
    jobTitle: 'Software Engineer',
    userName: 'johndoe',
    email: 'johndoe@me.com',
    password: '123456',
    avatarUrl: 'https://avatars.githubusercontent.com/u/1?v=4',
  );

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(10.0),
            icon: const Icon(Icons.email),
            onPressed: () {
              //TODO: Go to invitation screen
            },
          )
        ],
      ),
      body: ChangeNotifierProvider<ProfileScreenManager>(
          create: (context) => ProfileScreenManager(),
          child: ProfileInfo(user: ProfileScreen.temporaryUser)),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({required this.user, super.key});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: ProfileHeader(user: user)),
          Expanded(child: ProfileDetails(user: user)),
          ActionButtons(user: user)
        ],
      ),
    );
  }
}
