import 'package:flutter/material.dart';

import './ui/screens.dart';
import './models/index.dart';
import './themes/chanhub_theme.dart';
import './ui/shared/transition/transitions.dart';

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
      home: const GetStartedScreen(),
      onGenerateRoute: (settings) {
        // Authenticated routes
        if (settings.name == GetStartedScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const GetStartedScreen(),
          );
        }

        if (settings.name == LoginOrRegisterScreen.routeName) {
          final bool isLogin = settings.arguments as bool;

          return MaterialPageRoute(
            builder: (context) => LoginOrRegisterScreen(isLogin: isLogin),
          );
        }

        // Workspace
        if (settings.name == WorkspaceScreen.routeName) {
          final List<Workspace> workspaces = WorkspacesManager().getAll();
          final Workspace? selectedWorkspace =
              settings.arguments as Workspace? ??
                  WorkspacesManager().getDefaultWorkspace();

          return CustomSlideTransition(
            page: WorkspaceScreen(
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
          final Channel channel = ChannelsManager().getById('1')!;

          return CustomSlideTransition(
            page: ChannelScreen(channel),
          );
        }

        // Thread
        if (settings.name == ThreadScreen.routeName) {
          final String threadId = settings.arguments as String;
          final Thread thread = ThreadsManager().getById(threadId)!;
          final Channel channel = ChannelsManager().getById('1')!;

          return MaterialPageRoute(
            builder: (context) => ThreadScreen(
              thread,
              channelName: channel.name,
            ),
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
