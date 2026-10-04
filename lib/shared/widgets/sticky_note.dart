import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'torn_paper.dart';
import 'tape_strip.dart';

/// Reusable sticky note widget modeled after the moodboard notes:
/// - Pink "FUNKY but minimal"
/// - Yellow "COLLAGE of moments"
/// - Lime "DIFFERENT by design"
/// - Lime "or! surprise me" with dice
class StickyNote extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? icon;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final double rotation; // in radians
  final bool hasTape;
  final VoidCallback? onTap;

  const StickyNote({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.color = AppColors.lime,
    this.textColor = AppColors.nearBlack,
    this.width = 110,
    this.height = 80,
    this.rotation = 0.05,
    this.hasTape = false,
    this.onTap,
  });

  /// Factory for the "or! surprise me" lime note from Screen 2 (Plans)
  factory StickyNote.surpriseMe({
    VoidCallback? onTap,
    double rotation = -0.06,
  }) {
    return StickyNote(
      title: "or!",
      subtitle: "surprise me",
      color: AppColors.lime,
      width: 95,
      height: 90,
      rotation: rotation,
      icon: const _DiceDoodle(),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget note = TornPaper(
      color: color,
      edges: TornEdges.all,
      elevation: 5,
      tearDepth: 3,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      constraints: BoxConstraints(minWidth: width, minHeight: height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.markerHeading(
              fontSize: 16,
              color: textColor,
            ).copyWith(height: 1.0),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: AppTextStyles.handwritten(
                fontSize: 14,
                color: textColor,
              ).copyWith(height: 1.0),
            ),
          ],
          if (icon != null) ...[
            const SizedBox(height: 4),
            icon!,
          ],
        ],
      ),
    );

    if (hasTape) {
      note = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          note,
          const Positioned(
            top: -6,
            child: TapeStrip(width: 45, height: 16, rotation: -0.05),
          ),
        ],
      );
    }

    return Transform.rotate(
      angle: rotation,
      child: GestureDetector(
        onTap: onTap,
        child: note,
      ),
    );
  }
}

/// Hand-drawn mini dice doodle
class _DiceDoodle extends StatelessWidget {
  const _DiceDoodle();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(20, 20),
      painter: _DicePainter(),
    );
  }
}

class _DicePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = AppColors.nearBlack
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final dotPaint = Paint()
      ..color = AppColors.nearBlack
      ..style = PaintingStyle.fill;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
      const Radius.circular(3),
    );
    canvas.drawRRect(rrect, borderPaint);

    // Draw 5 dots
    final cx = size.width / 2;
    final cy = size.height / 2;
    const dotR = 1.4;

    canvas.drawCircle(Offset(cx, cy), dotR, dotPaint);
    canvas.drawCircle(Offset(cx - 4.5, cy - 4.5), dotR, dotPaint);
    canvas.drawCircle(Offset(cx + 4.5, cy - 4.5), dotR, dotPaint);
    canvas.drawCircle(Offset(cx - 4.5, cy + 4.5), dotR, dotPaint);
    canvas.drawCircle(Offset(cx + 4.5, cy + 4.5), dotR, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
