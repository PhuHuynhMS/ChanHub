import 'package:flutter/material.dart';

import './ui/screens.dart';
import './models/index.dart';
import './themes/chanhub_theme.dart';
import './ui/shared/transitions/index.dart';

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
      home: const FirstScreen(),
      onGenerateRoute: (settings) {
        // Onboarding
        if (settings.name == OnboardingScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: OnboardingScreen(),
            ),
          );
        }

        // Authenticated routes
        if (settings.name == GetStartedScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: GetStartedScreen(),
            ),
          );
        }

        if (settings.name == LoginOrRegisterScreen.routeName) {
          final bool isLogin = settings.arguments as bool;

          return MaterialPageRoute(
            builder: (context) => SafeArea(
              child: LoginOrRegisterScreen(isLogin: isLogin),
            ),
          );
        }

        // Workspace
        if (settings.name == WorkspaceScreen.routeName) {
          final List<Workspace> workspaces = WorkspacesManager().getAll();
          final Workspace? selectedWorkspace =
              settings.arguments as Workspace? ??
                  WorkspacesManager().getDefaultWorkspace();

          return CustomSlideTransition(
            page: SafeArea(
              child: WorkspaceScreen(
                workspaces,
                selectedWorkspace: selectedWorkspace,
              ),
            ),
          );
        }

        // Create Workspace
        if (settings.name == CreateWorkspaceScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: CreateWorkspaceScreen(),
            ),
          );
        }

        // Invite friends at create workspace
        if (settings.name == AddWorkspaceMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: AddWorkspaceMembersScreen(),
            ),
          );
        }

        // Workspace members
        if (settings.name == WorkspaceMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: WorkspaceMembersScreen(),
            ),
          );
        }

        // Channel
        if (settings.name == ChannelScreen.routeName) {
          final Channel channel = ChannelsManager().getById('1')!;

          return CustomSlideTransition(
            page: SafeArea(
              child: ChannelScreen(channel),
            ),
          );
        }

        // Edit channel
        if (settings.name == EditChannelScreen.routeName) {
          final Channel channel = ChannelsManager().getById('1')!;

          return MaterialPageRoute(
            builder: (context) => SafeArea(
              child: EditChannelScreen(
                channel,
              ),
            ),
          );
        }

        // Add channel
        if (settings.name == AddChannelScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: AddChannelScreen(),
            ),
          );
        }

        // View channel members
        if (settings.name == ViewChannelMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: ViewChannelMembersScreen(),
            ),
          );
        }

        // Add channel members
        if (settings.name == AddChannelMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: AddChannelMembersScreen(),
            ),
          );
        }

        // Thread
        if (settings.name == ThreadScreen.routeName) {
          final String threadId = settings.arguments as String;
          final Thread thread = ThreadsManager().getById(threadId)!;
          final Channel channel = ChannelsManager().getById('1')!;

          return MaterialPageRoute(
            builder: (context) => SafeArea(
              child: SafeArea(
                child: ThreadScreen(thread, channelName: channel.name),
              ),
            ),
          );
        }

        // Profile
        if (settings.name == ProfileScreen.routeName) {
          return CustomSlideTransition(
            page: const SafeArea(child: ProfileScreen()),
          );
        }

        if (settings.name == InvitationScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: InvitationScreen(),
            ),
          );
        }

        //Change password
        if (settings.name == ChangePasswordScreen.routeName) {
          return CustomSlideTransition(
            page: const SafeArea(
              child: ChangePasswordScreen(),
            ),
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
