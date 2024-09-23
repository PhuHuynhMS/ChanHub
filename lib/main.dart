import 'package:flutter/material.dart';

import 'ui/screens.dart';
import './themes/chanhub_theme.dart';
import './models/workspace.dart';

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
          final List<Workspace> workspaces = [];
          final Workspace? selectedWorkspace =
              settings.arguments as Workspace? ??
                  WorkspacesManager().getDefaultWorkspace();

          return MaterialPageRoute(
            builder: (context) => WorkspaceScreen(
              workspaces,
              selectedWorkspace: selectedWorkspace,
            ),
          );
        }

        // Create Workspace
        if (settings.name == CreateWorkspaceScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const CreateWorkspaceScreen(),
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
