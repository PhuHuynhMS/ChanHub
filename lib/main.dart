import 'package:ct484_project/ui/workspace/workspace_creation_screen.dart';
import 'package:flutter/material.dart';

import './ui/screen.dart';
import './themes/chanhub_theme.dart';

void main() {
  runApp(const ChanHub());
}

class ChanHub extends StatelessWidget {
  const ChanHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChanHub',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      initialRoute: WorkspaceScreen.routeName,
      onGenerateRoute: (settings) {
        // Authenticated routes
        if (settings.name == GetStartedScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const GetStartedScreen(),
          );
        }

        if (settings.name == LoginScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          );
        }

        if (settings.name == RegisterScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const RegisterScreen(),
          );
        }

        // Workspace
        if (settings.name == WorkspaceScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const WorkspaceScreen(),
          );
        }

        // Create Workspace
        if (settings.name == WorkspaceCreationScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const WorkspaceCreationScreen(),
          );
        }

        if (settings.name == ManagementScreen.routeName) {
          return MaterialPageRoute(
              builder: (context) => const ManagementScreen());
        }

        // Channel
        if (settings.name == ChannelScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const ChannelScreen(),
          );
        }

        // Thread
        if (settings.name == ThreadScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const ThreadScreen(),
          );
        }

        // Profile
        if (settings.name == ProfileScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          );
        }

        // Default route
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
        );
      },
    );
  }
}
