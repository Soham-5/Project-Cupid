import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Hand-drawn oval scribble loop painter (wraps words like "cool?" and "let's go!")
class ScribbleOvalPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final int seed;

  ScribbleOvalPainter({
    this.color = AppColors.lime,
    this.strokeWidth = 2.2,
    this.seed = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final rx = (size.width / 2) + 4.0;
    final ry = (size.height / 2) + 4.0;

    // Draw an organic double-loop ellipse with slight angular jitter
    final path = Path();
    const totalPoints = 36;
    const loops = 1.15; // slightly more than 1 full turn for overlapping sketch look

    for (int i = 0; i <= (totalPoints * loops); i++) {
      final angle = (i / totalPoints) * 2 * math.pi - (math.pi / 2);
      final jitterR = math.sin(i * 1.5 + seed) * 1.2;
      final x = cx + (rx + jitterR) * math.cos(angle);
      final y = cy + (ry + jitterR) * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ScribbleOvalPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

/// Wraps any child with a hand-drawn scribble oval loop
class ScribbleOvalWrapper extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final EdgeInsets padding;

  const ScribbleOvalWrapper({
    super.key,
    required this.child,
    this.color = AppColors.lime,
    this.strokeWidth = 2.2,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ScribbleOvalPainter(color: color, strokeWidth: strokeWidth),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

/// Hand-drawn underline doodle stroke (e.g. pink underline beneath "start talking")
class ScribbleUnderlinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  ScribbleUnderlinePainter({
    this.color = AppColors.pink,
    this.strokeWidth = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final y = size.height - 2;
    path.moveTo(2, y);

    // Natural hand-drawn wave
    final w = size.width;
    path.cubicTo(
      w * 0.25, y - 2.5,
      w * 0.65, y + 2.0,
      w - 2, y - 1.0,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ScribbleUnderlinePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

/// Pink or colored hand-drawn outline heart doodle
class HeartDoodle extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final double rotation;

  const HeartDoodle({
    super.key,
    this.size = 24,
    this.color = AppColors.pink,
    this.strokeWidth = 2.0,
    this.rotation = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        size: Size(size, size),
        painter: _HeartPainter(color: color, strokeWidth: strokeWidth),
      ),
    );
  }
}

class _HeartPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _HeartPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final path = Path();

    // Hand-drawn sketch heart
    path.moveTo(w * 0.5, h * 0.3);
    path.cubicTo(w * 0.2, -h * 0.05, -w * 0.05, h * 0.45, w * 0.5, h * 0.95);
    path.cubicTo(w * 1.05, h * 0.45, w * 0.8, -h * 0.05, w * 0.5, h * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _HeartPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

/// Sparkle / 4-point asterisk star doodle
class SparkleDoodle extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;

  const SparkleDoodle({
    super.key,
    this.size = 20,
    this.color = AppColors.nearBlack,
    this.strokeWidth = 1.8,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SparklePainter(color: color, strokeWidth: strokeWidth),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _SparklePainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Vertical line
    canvas.drawLine(Offset(cx, 1), Offset(cx, size.height - 1), paint);
    // Horizontal line
    canvas.drawLine(Offset(1, cy), Offset(size.width - 1, cy), paint);
    // Diagonal cross (shorter)
    final d = size.width * 0.22;
    canvas.drawLine(Offset(cx - d, cy - d), Offset(cx + d, cy + d), paint);
    canvas.drawLine(Offset(cx + d, cy - d), Offset(cx - d, cy + d), paint);
  }

  @override
  bool shouldRepaint(covariant _SparklePainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

/// Hand-drawn mini spider doodle
class SpiderDoodle extends StatelessWidget {
  final double size;
  final Color color;

  const SpiderDoodle({
    super.key,
    this.size = 22,
    this.color = AppColors.nearBlack,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SpiderPainter(color: color),
    );
  }
}

class _SpiderPainter extends CustomPainter {
  final Color color;

  _SpiderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final legPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Body (abdomen + cephalothorax)
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + 2), width: 7, height: 9),
      fillPaint,
    );
    canvas.drawCircle(Offset(cx, cy - 3.5), 3, fillPaint);

    // 4 legs on left
    void drawLeg(double yStart, double xMid, double yMid, double xEnd, double yEnd) {
      final p = Path();
      p.moveTo(cx - 3, cy + yStart);
      p.lineTo(cx - xMid, cy + yMid);
      p.lineTo(cx - xEnd, cy + yEnd);
      canvas.drawPath(p, legPaint);
    }

    void drawLegRight(double yStart, double xMid, double yMid, double xEnd, double yEnd) {
      final p = Path();
      p.moveTo(cx + 3, cy + yStart);
      p.lineTo(cx + xMid, cy + yMid);
      p.lineTo(cx + xEnd, cy + yEnd);
      canvas.drawPath(p, legPaint);
    }

    // Left legs
    drawLeg(-2, 7, -6, 9, -2);
    drawLeg(0, 8, -2, 10, 2);
    drawLeg(2, 8, 3, 9, 7);
    drawLeg(4, 7, 7, 8, 10);

    // Right legs
    drawLegRight(-2, 7, -6, 9, -2);
    drawLegRight(0, 8, -2, 10, 2);
    drawLegRight(2, 8, 3, 9, 7);
    drawLegRight(4, 7, 7, 8, 10);
  }

  @override
  bool shouldRepaint(covariant _SpiderPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Crescent moon doodle for late night drive
class MoonDoodle extends StatelessWidget {
  final double size;
  final Color color;

  const MoonDoodle({
    super.key,
    this.size = 20,
    this.color = AppColors.lime,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _MoonPainter(color: color),
    );
  }
}

class _MoonPainter extends CustomPainter {
  final Color color;

  _MoonPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.7, h * 0.15);
    path.cubicTo(w * 0.25, h * 0.2, w * 0.25, h * 0.8, w * 0.7, h * 0.85);
    path.cubicTo(w * 0.45, h * 0.7, w * 0.45, h * 0.3, w * 0.7, h * 0.15);

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _MoonPainter oldDelegate) =>
      oldDelegate.color != color;
}
