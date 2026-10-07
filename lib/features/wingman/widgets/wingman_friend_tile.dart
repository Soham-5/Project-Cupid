import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../models/wingman_models.dart';

class WingmanFriendTile extends StatelessWidget {
  final WingmanFriend friend;
  final String? overrideSubtitle;
  final bool showDivider;
  final VoidCallback onTap;

  const WingmanFriendTile({
    super.key,
    required this.friend,
    this.overrideSubtitle,
    this.showDivider = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.black.withValues(alpha: 0.04),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.nearBlack.withValues(alpha: 0.14),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            // Initial Paper Badge
            Transform.rotate(
              angle: friend.badgeRotationDeg * (math.pi / 180),
              child: ClipPath(
                clipper: const _BadgePolygonClipper(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: friend.badgeColor,
                    border: Border.all(color: AppColors.nearBlack, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    friend.initial,
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppColors.nearBlack,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Friend Name & Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    overrideSubtitle ?? friend.subtitle,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF625C52), // var(--muted)
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),

            // Handwritten arrow
            Transform.rotate(
              angle: -4 * (math.pi / 180),
              child: Text(
                '→',
                style: GoogleFonts.caveat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgePolygonClipper extends CustomClipper<Path> {
  const _BadgePolygonClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    // clip-path: polygon(6% 0, 93% 3%, 100% 90%, 10% 100%, 0 12%)
    return Path()
      ..moveTo(0.06 * w, 0.00 * h)
      ..lineTo(0.93 * w, 0.03 * h)
      ..lineTo(1.00 * w, 0.90 * h)
      ..lineTo(0.10 * w, 1.00 * h)
      ..lineTo(0.00 * w, 0.12 * h)
      ..close();
  }

  @override
  bool shouldReclip(covariant _BadgePolygonClipper oldClipper) => false;
}
