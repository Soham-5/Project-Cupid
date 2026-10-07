import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import 'wingman_doodle.dart';

class WingmanHeader extends StatelessWidget {
  const WingmanHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo Paper cutout
          Transform.rotate(
            angle: -2.0 * (math.pi / 180),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.11),
                    blurRadius: 6,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: ClipPath(
                clipper: const _LogoPaperClipper(),
                child: Container(
                  width: 48,
                  height: 48,
                  color: const Color(0xFFF8F2E7),
                  alignment: Alignment.center,
                  child: const WingmanDoodle(
                    size: 38,
                    color: AppColors.nearBlack,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Wordmark & Tagline
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Wingman',
                  style: GoogleFonts.kalam(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    height: 0.95,
                    letterSpacing: -0.5,
                    color: AppColors.nearBlack,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'your friend, your mission',
                  style: GoogleFonts.caveat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF625C52),
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          // "on call" tilted pink badge
          Transform.rotate(
            angle: 3.0 * (math.pi / 180),
            child: ClipPath(
              clipper: const _BadgeNoteClipper(),
              child: Container(
                color: AppColors.pink,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'on call',
                  style: GoogleFonts.caveat(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.nearBlack,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoPaperClipper extends CustomClipper<Path> {
  const _LogoPaperClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    // clip-path: polygon(2% 3%, 98% 0, 100% 93%, 8% 100%, 0 10%)
    return Path()
      ..moveTo(0.02 * w, 0.03 * h)
      ..lineTo(0.98 * w, 0.00 * h)
      ..lineTo(1.00 * w, 0.93 * h)
      ..lineTo(0.08 * w, 1.00 * h)
      ..lineTo(0.00 * w, 0.10 * h)
      ..close();
  }

  @override
  bool shouldReclip(covariant _LogoPaperClipper oldClipper) => false;
}

class _BadgeNoteClipper extends CustomClipper<Path> {
  const _BadgeNoteClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    // clip-path: polygon(2% 10%, 96% 0, 100% 90%, 4% 100%)
    return Path()
      ..moveTo(0.02 * w, 0.10 * h)
      ..lineTo(0.96 * w, 0.00 * h)
      ..lineTo(1.00 * w, 0.90 * h)
      ..lineTo(0.04 * w, 1.00 * h)
      ..close();
  }

  @override
  bool shouldReclip(covariant _BadgeNoteClipper oldClipper) => false;
}
