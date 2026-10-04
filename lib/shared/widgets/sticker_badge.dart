import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum StickerType { circle, starburst, smiley }

/// Reusable sticker badge widget (Lime circle "her vibe", smiley, or starburst)
class StickerBadge extends StatelessWidget {
  final StickerType type;
  final String? text;
  final double size;
  final Color backgroundColor;
  final Color textColor;
  final double rotation; // in radians
  final VoidCallback? onTap;

  const StickerBadge({
    super.key,
    this.type = StickerType.circle,
    this.text,
    this.size = 56,
    this.backgroundColor = AppColors.lime,
    this.textColor = AppColors.nearBlack,
    this.rotation = -0.15, // ~ -8.5 degrees
    this.onTap,
  });

  /// Factory for the "her vibe" lime sticker from Screen 1
  factory StickerBadge.herVibe({double size = 62, double rotation = -0.12}) {
    return StickerBadge(
      type: StickerType.circle,
      text: "her\nvibe",
      size: size,
      backgroundColor: AppColors.lime,
      textColor: AppColors.nearBlack,
      rotation: rotation,
    );
  }

  /// Factory for the lime smiley sticker from Screen 3
  factory StickerBadge.smiley({double size = 52, double rotation = -0.1}) {
    return StickerBadge(
      type: StickerType.smiley,
      size: size,
      backgroundColor: AppColors.lime,
      rotation: rotation,
    );
  }

  /// Factory for the starburst sticker from Screen 2
  factory StickerBadge.starburst({
    double size = 44,
    Color color = AppColors.lavender,
    double rotation = 0.2,
  }) {
    return StickerBadge(
      type: StickerType.starburst,
      size: size,
      backgroundColor: color,
      rotation: rotation,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (type) {
      case StickerType.circle:
        content = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 5,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: text != null
              ? Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.markerHeading(
                    fontSize: size * 0.26,
                    color: textColor,
                    letterSpacing: 0.1,
                  ).copyWith(height: 0.95),
                )
              : null,
        );
        break;

      case StickerType.smiley:
        content = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.22),
                blurRadius: 5,
                offset: const Offset(1, 3),
              ),
            ],
          ),
          child: CustomPaint(
            size: Size(size, size),
            painter: _SmileyPainter(color: textColor),
          ),
        );
        break;

      case StickerType.starburst:
        content = CustomPaint(
          size: Size(size, size),
          painter: _StarburstPainter(
            color: backgroundColor,
            points: 12,
            innerRadiusFactor: 0.72,
          ),
        );
        break;
    }

    return Transform.rotate(
      angle: rotation,
      child: GestureDetector(
        onTap: onTap,
        child: content,
      ),
    );
  }
}

class _SmileyPainter extends CustomPainter {
  final Color color;

  _SmileyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final eyeW = size.width * 0.08;
    final eyeH = size.height * 0.12;

    // Left eye
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - size.width * 0.18, cy - size.height * 0.1),
        width: eyeW,
        height: eyeH,
      ),
      paint,
    );

    // Right eye
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + size.width * 0.18, cy - size.height * 0.1),
        width: eyeW,
        height: eyeH,
      ),
      paint,
    );

    // Happy smile arc
    final mouthRect = Rect.fromCircle(
      center: Offset(cx, cy - size.height * 0.05),
      radius: size.width * 0.28,
    );
    canvas.drawArc(mouthRect, math.pi * 0.15, math.pi * 0.7, false, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _SmileyPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _StarburstPainter extends CustomPainter {
  final Color color;
  final int points;
  final double innerRadiusFactor;

  _StarburstPainter({
    required this.color,
    this.points = 12,
    this.innerRadiusFactor = 0.7,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final outerR = size.width / 2;
    final innerR = outerR * innerRadiusFactor;

    final path = Path();
    final step = math.pi / points;

    for (int i = 0; i < points * 2; i++) {
      final r = (i % 2 == 0) ? outerR : innerR;
      final angle = i * step - math.pi / 2;
      final x = cx + r * math.cos(angle);
      final y = cy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.save();
    canvas.translate(1, 2.5);
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _StarburstPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.points != points;
}
