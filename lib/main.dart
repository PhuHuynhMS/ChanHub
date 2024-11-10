import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './models/index.dart';
import './managers/index.dart';
import './services/index.dart';
import './themes/chanhub_theme.dart';
import './ui/screens.dart';
import './ui/shared/transitions/index.dart';

void main() async {
  // Initialize services
  await dotenv.load();
  await LocalStorageService.getInstance();
  await PocketBaseService.getInstance();

  runApp(const ChanHub());
}

class ChanHub extends StatelessWidget {
  const ChanHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingManager()..init()),
        ChangeNotifierProvider(create: (_) => AuthManager()),
        ChangeNotifierProvider(create: (_) => WorkspacesManager()),
        ChangeNotifierProvider(create: (_) => InvitationsManager()),
        ListenableProxyProvider<WorkspacesManager, ChannelsManager>(
            create: (_) => ChannelsManager(),
            update: (_, workspacesManager, channelsManager) => channelsManager!
              ..fetchChannels(workspacesManager.getSelectedWorkspace()?.id)),
        ChangeNotifierProvider(create: (_) => UsersManager())
      ],
      child: Consumer2<OnboardingManager, AuthManager>(
        builder: (ctx, onboardingManager, authManager, child) {
          if (authManager.isLoggedIn) {
            // Initialize the app
            ctx.read<WorkspacesManager>().fetchWorkspaces();
          }

          return MaterialApp(
            title: 'ChanHub',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: SafeArea(
              child: _buildHomeScreen(context, authManager, onboardingManager),
            ),
            onGenerateRoute: _onGenerateRoute,
          );
        },
      ),
    );
  }

  Widget _buildHomeScreen(
    BuildContext context,
    AuthManager authManager,
    OnboardingManager onboardingManager,
  ) {
    if (onboardingManager.isLoading) {
      return const SplashScreen();
    }

    if (onboardingManager.isFirstTime) {
      return const OnboardingScreen();
    }

    if (authManager.isLoggedIn) {
      return const WorkspaceScreen();
    }

    return FutureBuilder(
      future: authManager.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        return const LoginOrRegisterScreen(isLogin: true);
      },
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    // Onboarding
    if (settings.name == OnboardingScreen.routeName) {
      return MaterialPageRoute(
        builder: (context) => const SafeArea(
          child: OnboardingScreen(),
        ),
      );
    }

    // Authentication
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
      return MaterialPageRoute(
        builder: (context) => const SafeArea(
          child: WorkspaceScreen(),
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
      final agrs = settings.arguments as Map<String, dynamic>;
      final workspaceName = agrs['workspaceName'];
      final image = agrs['image'];
      final isCreating = agrs['isCreating'];

      return MaterialPageRoute(
        builder: (context) => SafeArea(
          child: AddWorkspaceMembersScreen(
            workspaceName: workspaceName,
            image: image,
            isCreating: isCreating,
          ),
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
      return CustomSlideTransition(
        page: const SafeArea(
          child: ChannelScreen(),
        ),
      );
    }

    if (settings.name == EditChannelScreen.routeName) {
      final Channel channel = settings.arguments as Channel;

      return CustomSlideTransition(
        page: SafeArea(
          child: EditChannelScreen(channel),
        ),
      );
    }

    if (settings.name == AddChannelScreen.routeName) {
      return CustomSlideTransition(
        page: const SafeArea(
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
      return CustomSlideTransition(
        page: SafeArea(
          child: ThreadScreen(threadId),
        ),
      );
    }

    // Profile
    if (settings.name == ProfileScreen.routeName) {
      final User user = settings.arguments as User;

      return CustomSlideTransition(
        page: SafeArea(
          child: ProfileScreen(user),
        ),
      );
    }

    if (settings.name == InvitationScreen.routeName) {
      return CustomSlideTransition(
        page: const SafeArea(
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
  }
}
