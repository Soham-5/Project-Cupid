import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/custom_bottom_nav.dart';
import '../../data/repositories/mock_dating_repository.dart';
import '../wingman/wingman_config.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  static List<String> getRoutes() {
    if (WingmanConfig.enabled) {
      return const [
        '/home',
        '/plans',
        '/match',
        '/vibes',
        '/wingman',
        '/profile',
      ];
    }
    return const [
      '/home',
      '/plans',
      '/match',
      '/vibes',
      '/profile',
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = getRoutes();
    final location = GoRouterState.of(context).matchedLocation;

    int currentIndex = routes.indexOf(location);
    if (currentIndex == -1) {
      final savedIndex = ref.watch(activeBottomNavIndexProvider);
      currentIndex = (savedIndex < routes.length) ? savedIndex : 0;
    }

    // Determine scaffold background based on current route
    final isDarkRoute = location == '/plans' || location == '/profile';
    final scaffoldBg = isDarkRoute ? AppColors.nearBlack : AppColors.cream;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: child,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          if (index < routes.length) {
            ref.read(activeBottomNavIndexProvider.notifier).state = index;
            context.go(routes[index]);
          }
        },
      ),
    );
  }
}
