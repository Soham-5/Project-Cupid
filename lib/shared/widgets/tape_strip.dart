import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Translucent masking tape strip widget with authentic jagged edges and subtle sheen.
class TapeStrip extends StatelessWidget {
  final double width;
  final double height;
  final double rotation; // in radians
  final Color color;

  const TapeStrip({
    super.key,
    this.width = 65,
    this.height = 20,
    this.rotation = -0.15, // ~ -8.5 degrees
    this.color = AppColors.tape,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        size: Size(width, height),
        painter: _TapePainter(color: color),
      ),
    );
  }
}

class _TapePainter extends CustomPainter {
  final Color color;

  _TapePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Build tape path with jagged serrated left and right edges
    final path = Path();
    path.moveTo(3, 0);

    // Top straight edge
    path.lineTo(w - 3, 0);

    // Serrated right edge
    const teeth = 5;
    final toothH = h / teeth;
    for (int i = 0; i < teeth; i++) {
      final yMid = (i + 0.5) * toothH;
      final yEnd = (i + 1) * toothH;
      final xJag = (i % 2 == 0) ? w : w - 3.5;
      path.lineTo(xJag, yMid);
      path.lineTo(w - 1.5, yEnd);
    }

    // Bottom straight edge
    path.lineTo(3, h);

    // Serrated left edge
    for (int i = teeth; i > 0; i--) {
      final yMid = (i - 0.5) * toothH;
      final yEnd = (i - 1) * toothH;
      final xJag = (i % 2 == 0) ? 0.0 : 3.5;
      path.lineTo(xJag, yMid);
      path.lineTo(1.5, yEnd);
    }

    path.close();

    // Subtle drop shadow under tape
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    canvas.save();
    canvas.translate(0, 1.0);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // Main tape body
    final tapePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, tapePaint);

    // Subtle diagonal fiber sheen lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (double x = -h; x < w; x += 12) {
      canvas.drawLine(
        Offset(math.max(2, x), 2),
        Offset(math.min(w - 2, x + h), h - 2),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TapePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
