import 'package:flutter/material.dart';

/// GPU-accelerated custom PageRoute that slides in smoothly from the right
/// over ~300ms with ease-out curve and subtle fade, reversing on pop.
class WorkspaceSlideRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  WorkspaceSlideRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            final slideAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(curvedAnimation);

            final fadeAnimation = Tween<double>(
              begin: 0.85,
              end: 1.0,
            ).animate(curvedAnimation);

            return SlideTransition(
              position: slideAnimation,
              child: FadeTransition(
                opacity: fadeAnimation,
                child: child,
              ),
            );
          },
        );

  /// Helper to open the workspace smoothly over the current screen
  static Future<T?> open<T>(BuildContext context, Widget targetPage) {
    return Navigator.of(context, rootNavigator: true).push<T>(
      WorkspaceSlideRoute<T>(page: targetPage),
    );
  }
}
