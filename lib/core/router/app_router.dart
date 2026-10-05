import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/shell/main_scaffold.dart';
import '../../features/home/home_screen.dart';
import '../../features/plans/plans_screen.dart';
import '../../features/match/match_screen.dart';
import '../../features/vibes/vibes_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/wingman/presentation/wingman_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/plans',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PlansScreen(),
            ),
          ),
          GoRoute(
            path: '/match',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MatchScreen(),
            ),
          ),
          GoRoute(
            path: '/vibes',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: VibesScreen(),
            ),
          ),
          GoRoute(
            path: '/wingman',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: WingmanScreen(),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
