import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../models/wingman_models.dart';

class WingmanCandidateCard extends StatelessWidget {
  final WingmanCandidate candidate;

  const WingmanCandidateCard({
    super.key,
    required this.candidate,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -1.0 * (math.pi / 180),
      child: Container(
        width: 270,
        decoration: BoxDecoration(
          color: const Color(0xFFF7F1E6),
          boxShadow: [
            BoxShadow(
              color: AppColors.nearBlack.withValues(alpha: 0.9),
              offset: const Offset(8, 10),
              blurRadius: 0,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo Area with silhouette / illustration
            ClipPath(
              clipper: const _PhotoScrapClipper(),
              child: Container(
                height: 280,
                color: candidate.backgroundColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // If image is present and exists, show image with color blend or silhouette
                    if (candidate.photoAsset != null)
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.88,
                          child: Image.asset(
                            candidate.photoAsset!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      ),

                    // Vector silhouette overlay (head and shoulders) matching prototype
                    CustomPaint(
                      size: const Size(200, 240),
                      painter: _SilhouettePainter(
                        fillColor: const Color(0xFFF4EEE2),
                        borderColor: AppColors.nearBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Profile Label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  candidate.name,
                  style: GoogleFonts.barlowCondensed(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppColors.nearBlack,
                  ),
                ),
                Text(
                  candidate.age.toString(),
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.nearBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Traits badges
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List.generate(candidate.traits.length, (i) {
                final trait = candidate.traits[i];
                final Color bg;
                if (i == 1) {
                  bg = AppColors.lime;
                } else if (i == 2) {
                  bg = AppColors.pink;
                } else {
                  bg = const Color(0xFFFFF9EC);
                }

                return ClipPath(
                  clipper: const _TraitBadgeClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: bg,
                      border: Border.all(color: AppColors.nearBlack, width: 1.5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    child: Text(
                      trait,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.nearBlack,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoScrapClipper extends CustomClipper<Path> {
  const _PhotoScrapClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    // clip-path: polygon(2% 0, 99% 1%, 100% 98%, 1% 100%, 0 5%)
    return Path()
      ..moveTo(0.02 * w, 0.00 * h)
      ..lineTo(0.99 * w, 0.01 * h)
      ..lineTo(1.00 * w, 0.98 * h)
      ..lineTo(0.01 * w, 1.00 * h)
      ..lineTo(0.00 * w, 0.05 * h)
      ..close();
  }

  @override
  bool shouldReclip(covariant _PhotoScrapClipper oldClipper) => false;
}

class _TraitBadgeClipper extends CustomClipper<Path> {
  const _TraitBadgeClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    // clip-path: polygon(2% 7%, 98% 0, 100% 90%, 4% 100%)
    return Path()
      ..moveTo(0.02 * w, 0.07 * h)
      ..lineTo(0.98 * w, 0.00 * h)
      ..lineTo(1.00 * w, 0.90 * h)
      ..lineTo(0.04 * w, 1.00 * h)
      ..close();
  }

  @override
  bool shouldReclip(covariant _TraitBadgeClipper oldClipper) => false;
}

class _SilhouettePainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;

  _SilhouettePainter({required this.fillColor, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final cx = size.width / 2;

    // Head circle (diameter ~80)
    const headRadius = 40.0;
    const headCenterY = 95.0;
    final headOffset = Offset(cx, headCenterY);
    canvas.drawCircle(headOffset, headRadius, fillPaint);
    canvas.drawCircle(headOffset, headRadius, strokePaint);

    // Torso rounded arch
    final torsoPath = Path();
    final torsoW = size.width * 0.75;
    final torsoLeft = cx - torsoW / 2;
    final torsoRight = cx + torsoW / 2;
    final torsoBottom = size.height;
    final torsoTop = headCenterY + headRadius + 12;

    torsoPath.moveTo(torsoLeft, torsoBottom);
    torsoPath.lineTo(torsoLeft, torsoTop + 24);
    torsoPath.quadraticBezierTo(cx, torsoTop - 6, torsoRight, torsoTop + 24);
    torsoPath.lineTo(torsoRight, torsoBottom);
    torsoPath.close();

    canvas.drawPath(torsoPath, fillPaint);
    // Draw top border only for shoulder arch
    final shoulderBorder = Path()
      ..moveTo(torsoLeft, torsoBottom)
      ..lineTo(torsoLeft, torsoTop + 24)
      ..quadraticBezierTo(cx, torsoTop - 6, torsoRight, torsoTop + 24)
      ..lineTo(torsoRight, torsoBottom);
    canvas.drawPath(shoulderBorder, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _SilhouettePainter oldDelegate) => false;
}
