import 'package:flutter/material.dart';

/// Central action handler for all interactive Wingman workspace elements.
/// Currently logs the unique element ID to the console.
void handleWingmanAction(String id) {
  debugPrint('[WingmanAction] $id');
}

/// Helper to produce clean URL/slug strings for dynamic IDs.
String toWingmanSlug(String text) {
  return text
      .toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
}

/// A reusable interactive wrapper that provides:
/// 1. Stable identifier via Key and Semantics(identifier: id)
/// 2. Micro-press animation (slight organic scale down on tap)
/// 3. Central logging through [handleWingmanAction]
class WingmanInteractive extends StatefulWidget {
  final String id;
  final Widget child;
  final VoidCallback? customOnTap;
  final HitTestBehavior behavior;

  const WingmanInteractive({
    super.key,
    required this.id,
    required this.child,
    this.customOnTap,
    this.behavior = HitTestBehavior.opaque,
  });

  @override
  State<WingmanInteractive> createState() => _WingmanInteractiveState();
}

class _WingmanInteractiveState extends State<WingmanInteractive> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: widget.id,
      label: widget.id,
      child: GestureDetector(
        key: ValueKey(widget.id),
        behavior: widget.behavior,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          handleWingmanAction(widget.id);
          widget.customOnTap?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : 1.0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}
