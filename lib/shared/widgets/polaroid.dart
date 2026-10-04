import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'tape_strip.dart';

enum TapePlacement { none, topLeft, topRight, topCenter, bottomLeft, bottomRight }

/// Grayscale ColorFilter matrix for authentic high-contrast B&W photo look
const List<double> kGrayscaleMatrix = <double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
];

/// A Polaroid / PhotoScrap widget featuring:
/// - Thin cream frame with optional taller polaroid bottom border
/// - Slight organic rotation (-4° to +4°)
/// - Soft realistic drop shadow
/// - Grayscale ColorFiltered mode for punchy B&W photo aesthetic
/// - Integrated optional TapeStrip
class Polaroid extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final double rotation; // in radians
  final bool isGrayscale;
  final bool isPolaroid; // taller bottom chin
  final TapePlacement tapePlacement;
  final double tapeRotation;
  final double elevation;
  final VoidCallback? onTap;

  const Polaroid({
    super.key,
    required this.imagePath,
    this.width = 140,
    this.height = 160,
    this.rotation = 0.04, // ~2.3 degrees
    this.isGrayscale = false,
    this.isPolaroid = true,
    this.tapePlacement = TapePlacement.topCenter,
    this.tapeRotation = -0.1,
    this.elevation = 6.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) => Container(
        color: const Color(0xFFD4C9BC),
        child: const Icon(Icons.broken_image, color: Colors.black45),
      ),
    );

    if (isGrayscale) {
      imageWidget = ColorFiltered(
        colorFilter: const ColorFilter.matrix(kGrayscaleMatrix),
        child: imageWidget,
      );
    }

    final double topBorder = isPolaroid ? 8.0 : 5.0;
    final double sideBorder = isPolaroid ? 8.0 : 5.0;
    final double bottomBorder = isPolaroid ? 22.0 : 5.0;

    final photoCard = GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.creamLight,
          borderRadius: BorderRadius.circular(2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: elevation,
              offset: Offset(0, elevation * 0.5),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(sideBorder, topBorder, sideBorder, bottomBorder),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1),
          child: imageWidget,
        ),
      ),
    );

    Widget content = photoCard;

    // Attach tape strip if requested
    if (tapePlacement != TapePlacement.none) {
      double tapeTop = -8;
      double? tapeLeft;
      double? tapeRight;
      double? tapeBottom;

      switch (tapePlacement) {
        case TapePlacement.topLeft:
          tapeLeft = 8;
          break;
        case TapePlacement.topRight:
          tapeRight = 8;
          break;
        case TapePlacement.topCenter:
          tapeLeft = (width - 55) / 2;
          break;
        case TapePlacement.bottomLeft:
          tapeTop = height - 12;
          tapeLeft = 8;
          break;
        case TapePlacement.bottomRight:
          tapeTop = height - 12;
          tapeRight = 8;
          break;
        case TapePlacement.none:
          break;
      }

      content = Stack(
        clipBehavior: Clip.none,
        children: [
          photoCard,
          Positioned(
            top: tapeTop,
            left: tapeLeft,
            right: tapeRight,
            bottom: tapeBottom,
            child: TapeStrip(
              width: 55,
              height: 18,
              rotation: tapeRotation,
            ),
          ),
        ],
      );
    }

    return Transform.rotate(
      angle: rotation,
      child: content,
    );
  }
}
