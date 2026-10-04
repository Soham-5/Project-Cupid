import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Which edges of the paper should appear torn
class TornEdges {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const TornEdges({
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
  });

  static const all = TornEdges(top: true, bottom: true, left: true, right: true);
  static const topAndBottom = TornEdges(top: true, bottom: true);
  static const bottomOnly = TornEdges(bottom: true);
  static const topOnly = TornEdges(top: true);
  static const horizontal = TornEdges(left: true, right: true);
}

/// Creates a deterministic jagged torn edge path for paper scraps
class TornPaperClipper extends CustomClipper<Path> {
  final TornEdges edges;
  final int seed;
  final double tearDepth;

  const TornPaperClipper({
    this.edges = TornEdges.bottomOnly,
    this.seed = 42,
    this.tearDepth = 4.5,
  });

  @override
  Path getClip(Size size) {
    return _buildTornPath(size, edges, seed, tearDepth);
  }

  @override
  bool shouldReclip(covariant TornPaperClipper oldClipper) {
    return oldClipper.edges != edges ||
        oldClipper.seed != seed ||
        oldClipper.tearDepth != tearDepth;
  }
}

Path _buildTornPath(Size size, TornEdges edges, int seed, double depth) {
  final path = Path();
  final w = size.width;
  final h = size.height;

  // We use deterministic sine/cosine formula based on seed for consistent organic roughness
  double jitter(double t, int s) {
    final x = t * 13.0 + s * 1.618;
    return (math.sin(x) * 0.5 + math.cos(x * 2.3) * 0.35 + math.sin(x * 5.1) * 0.15);
  }

  // Top edge
  if (edges.top) {
    const step = 6.0;
    path.moveTo(0, depth + jitter(0, seed) * depth);
    for (double x = step; x <= w; x += step) {
      final t = x / w;
      final y = depth + jitter(t, seed) * depth;
      path.lineTo(x, y.clamp(0.0, depth * 2));
    }
  } else {
    path.moveTo(0, 0);
    path.lineTo(w, 0);
  }

  // Right edge
  if (edges.right) {
    const step = 6.0;
    for (double y = step; y <= h; y += step) {
      final t = y / h;
      final x = w - depth + jitter(t, seed + 10) * depth;
      path.lineTo(x.clamp(w - depth * 2, w), y);
    }
  } else {
    path.lineTo(w, h);
  }

  // Bottom edge
  if (edges.bottom) {
    const step = 6.0;
    for (double x = w - step; x >= 0; x -= step) {
      final t = x / w;
      final y = h - depth + jitter(t, seed + 20) * depth;
      path.lineTo(x, y.clamp(h - depth * 2, h));
    }
    path.lineTo(0, h - depth);
  } else {
    path.lineTo(0, h);
  }

  // Left edge
  if (edges.left) {
    const step = 6.0;
    for (double y = h - step; y >= 0; y -= step) {
      final t = y / h;
      final x = depth + jitter(t, seed + 30) * depth;
      path.lineTo(x.clamp(0.0, depth * 2), y);
    }
  } else {
    path.lineTo(0, 0);
  }

  path.close();
  return path;
}

/// A container with an irregular, hand-torn edge, drop shadow, and fill color.
class TornPaper extends StatelessWidget {
  final Widget child;
  final Color color;
  final TornEdges edges;
  final int seed;
  final double tearDepth;
  final double elevation;
  final Color shadowColor;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final BoxBorder? border;

  const TornPaper({
    super.key,
    required this.child,
    this.color = AppColors.cream,
    this.edges = TornEdges.bottomOnly,
    this.seed = 42,
    this.tearDepth = 4.0,
    this.elevation = 4.0,
    this.shadowColor = AppColors.paperShadow,
    this.padding = const EdgeInsets.all(12),
    this.width,
    this.height,
    this.constraints,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final clipper = TornPaperClipper(
      edges: edges,
      seed: seed,
      tearDepth: tearDepth,
    );

    return CustomPaint(
      painter: _TornPaperShadowPainter(
        clipper: clipper,
        elevation: elevation,
        shadowColor: shadowColor,
      ),
      child: ClipPath(
        clipper: clipper,
        child: Container(
          width: width,
          height: height,
          constraints: constraints,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            border: border,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TornPaperShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final double elevation;
  final Color shadowColor;

  _TornPaperShadowPainter({
    required this.clipper,
    required this.elevation,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (elevation <= 0) return;
    final path = clipper.getClip(size);
    final paint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation * 1.2);

    canvas.save();
    canvas.translate(0, elevation * 0.7);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _TornPaperShadowPainter oldDelegate) {
    return oldDelegate.elevation != elevation ||
        oldDelegate.shadowColor != shadowColor;
  }
}
