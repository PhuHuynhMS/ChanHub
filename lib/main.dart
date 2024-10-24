import 'package:flutter/material.dart';

import './models/index.dart';
import './managers/index.dart';
import './themes/chanhub_theme.dart';
import './ui/screens.dart';
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

        // Authentication
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

        if (settings.name == CreateWorkspaceScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: CreateWorkspaceScreen(),
            ),
          );
        }

        if (settings.name == AddWorkspaceMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: AddWorkspaceMembersScreen(),
            ),
          );
        }

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

        if (settings.name == AddChannelScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: AddChannelScreen(),
            ),
          );
        }

        if (settings.name == ViewChannelMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: ViewChannelMembersScreen(),
            ),
          );
        }

        if (settings.name == AddChannelMembersScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: AddChannelMembersScreen(),
            ),
          );
        }

        if (settings.name == SearchThreadScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const SafeArea(
              child: SearchThreadScreen(),
            ),
          );
        }

        // Thread Detail
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
