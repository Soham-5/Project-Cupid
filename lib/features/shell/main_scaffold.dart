import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/custom_bottom_nav.dart';
import '../../data/repositories/mock_dating_repository.dart';

class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  static const List<String> _routes = [
    '/home',
    '/plans',
    '/match',
    '/vibes',
    '/profile',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(activeBottomNavIndexProvider);

    // Determine scaffold background based on current route
    final isDarkRoute = currentIndex == 1 || currentIndex == 4; // Plans & Arjun Profile
    final scaffoldBg = isDarkRoute ? AppColors.nearBlack : AppColors.cream;

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: child,
      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTabSelected: (index) {
          ref.read(activeBottomNavIndexProvider.notifier).state = index;
          context.go(_routes[index]);
        },
      ),
    );
  }
}
