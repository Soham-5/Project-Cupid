import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Hand-drawn wingman icon (feathered wings with heart doodle).
class WingmanDoodle extends StatelessWidget {
  final double size;
  final Color color;

  const WingmanDoodle({
    super.key,
    this.size = 28,
    this.color = AppColors.nearBlack,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _WingmanDoodlePainter(color: color),
    );
  }
}

class _WingmanDoodlePainter extends CustomPainter {
  final Color color;

  _WingmanDoodlePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    // Left Wing
    final leftWing = Path()
      ..moveTo(cx - 3, cy - 2)
      ..cubicTo(cx - 8, cy - 10, cx - w * 0.42, cy - h * 0.42, cx - w * 0.45, cy - h * 0.25)
      ..cubicTo(cx - w * 0.48, cy - h * 0.05, cx - w * 0.35, cy + h * 0.12, cx - w * 0.22, cy + h * 0.15)
      ..cubicTo(cx - w * 0.12, cy + h * 0.16, cx - 6, cy + 6, cx - 3, cy + 2);

    // Left feather lines
    leftWing.moveTo(cx - w * 0.38, cy - h * 0.15);
    leftWing.quadraticBezierTo(cx - w * 0.22, cy - h * 0.05, cx - 6, cy - 2);

    leftWing.moveTo(cx - w * 0.32, cy + h * 0.04);
    leftWing.quadraticBezierTo(cx - w * 0.18, cy + h * 0.06, cx - 5, cy + 1);

    canvas.drawPath(leftWing, paint);

    // Right Wing
    final rightWing = Path()
      ..moveTo(cx + 3, cy - 2)
      ..cubicTo(cx + 8, cy - 10, cx + w * 0.42, cy - h * 0.42, cx + w * 0.45, cy - h * 0.25)
      ..cubicTo(cx + w * 0.48, cy - h * 0.05, cx + w * 0.35, cy + h * 0.12, cx + w * 0.22, cy + h * 0.15)
      ..cubicTo(cx + w * 0.12, cy + h * 0.16, cx + 6, cy + 6, cx + 3, cy + 2);

    // Right feather lines
    rightWing.moveTo(cx + w * 0.38, cy - h * 0.15);
    rightWing.quadraticBezierTo(cx + w * 0.22, cy - h * 0.05, cx + 6, cy - 2);

    rightWing.moveTo(cx + w * 0.32, cy + h * 0.04);
    rightWing.quadraticBezierTo(cx + w * 0.18, cy + h * 0.06, cx + 5, cy + 1);

    canvas.drawPath(rightWing, paint);

    // Center sketch heart / gem
    final heart = Path()
      ..moveTo(cx, cy + h * 0.22)
      ..cubicTo(cx - 7, cy + h * 0.12, cx - 8, cy - 1, cx, cy - 4)
      ..cubicTo(cx + 8, cy - 1, cx + 7, cy + h * 0.12, cx, cy + h * 0.22);

    canvas.drawPath(heart, paint);
  }

  @override
  bool shouldRepaint(covariant _WingmanDoodlePainter oldDelegate) =>
      oldDelegate.color != color;
}
