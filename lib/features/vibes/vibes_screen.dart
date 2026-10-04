import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/torn_paper.dart';
import '../../shared/widgets/tape_strip.dart';
import '../../shared/widgets/sticker_badge.dart';
import '../../shared/widgets/sticky_note.dart';

class VibesScreen extends StatelessWidget {
  const VibesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 480 ? 440.0 : screenWidth;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Header
                  Text(
                    "vibes & moments",
                    style: AppTextStyles.handwritten(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppColors.nearBlack,
                    ),
                  ).animate().fadeIn(duration: 300.ms),

                  const SizedBox(height: 24),

                  // Purple Torn Note: "WHY THIS STANDS OUT" from the moodboard
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      TornPaper(
                        color: AppColors.lavender,
                        edges: TornEdges.all,
                        seed: 49,
                        tearDepth: 5.0,
                        elevation: 8,
                        padding: const EdgeInsets.fromLTRB(26, 24, 26, 26),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WHY THIS\nSTANDS OUT",
                              style: AppTextStyles.markerHeading(
                                fontSize: 24,
                                color: AppColors.nearBlack,
                                letterSpacing: 0.5,
                              ).copyWith(height: 1.05),
                            ),
                            const SizedBox(height: 16),
                            _buildBulletItem("collage > swipe"),
                            _buildBulletItem("plans > profiles"),
                            _buildBulletItem("friends > algorithms"),
                            _buildBulletItem("vibes > perfection"),
                            const SizedBox(height: 12),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "◡̈",
                                style: AppTextStyles.handwritten(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.nearBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Top tape strip
                      const Positioned(
                        top: -8,
                        right: 40,
                        child: TapeStrip(width: 65, height: 20, rotation: 0.05),
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

                  const SizedBox(height: 32),

                  // Sticky notes row from moodboard: "FUNKY but minimal", "COLLAGE of moments", "DIFFERENT by design"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StickyNote(
                        title: "FUNKY",
                        subtitle: "but minimal",
                        color: AppColors.pink,
                        width: 105,
                        height: 85,
                        rotation: -0.08,
                      ),
                      StickyNote(
                        title: "DIFFERENT",
                        subtitle: "by design",
                        color: AppColors.lime,
                        width: 110,
                        height: 85,
                        rotation: 0.07,
                      ),
                    ],
                  ).animate().fadeIn(delay: 350.ms),

                  const SizedBox(height: 24),

                  // Active conversation starter card with Arjun
                  TornPaper(
                    color: AppColors.cardDark,
                    edges: TornEdges.all,
                    seed: 34,
                    tearDepth: 4.0,
                    elevation: 6,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipOval(
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: Image.asset('assets/images/arjun_camera.jpg', fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chat with Arjun",
                                style: AppTextStyles.markerHeading(
                                  fontSize: 18,
                                  color: AppColors.cream,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "plans: Spider-Man tonight? 🎬",
                                style: AppTextStyles.bodySans(
                                  fontSize: 12.5,
                                  color: AppColors.cream.withValues(alpha: 0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        StickerBadge.starburst(size: 28, color: AppColors.pink),
                      ],
                    ),
                  ).animate().fadeIn(delay: 450.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.nearBlack,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppTextStyles.bodySans(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: AppColors.nearBlack,
            ),
          ),
        ],
      ),
    );
  }
}
