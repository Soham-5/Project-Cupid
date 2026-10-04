import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/polaroid.dart';
import '../../shared/widgets/micro_doodles.dart';
import '../../shared/widgets/handwritten_pill_button.dart';
import '../../data/repositories/mock_dating_repository.dart';

class MatchScreen extends ConsumerWidget {
  const MatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),

                  // Header: "it's a match!" + Pink Heart Doodle
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "it's a match!",
                          style: AppTextStyles.handwritten(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            color: AppColors.nearBlack,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: HeartDoodle(size: 26, color: AppColors.pink, rotation: 0.18),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.85, 0.85)),

                  const SizedBox(height: 28),

                  // Dual Tilted Polaroids (Sara & Arjun side by side)
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Left Polaroid (Sara)
                        Positioned(
                          left: (contentWidth / 2) - 150,
                          top: 10,
                          child: const Polaroid(
                            imagePath: 'assets/images/sara_hero.jpg',
                            width: 135,
                            height: 185,
                            rotation: -0.07,
                            isPolaroid: true,
                            tapePlacement: TapePlacement.topCenter,
                            tapeRotation: -0.15,
                            elevation: 8,
                          ),
                        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),

                        // Right Polaroid (Arjun)
                        Positioned(
                          right: (contentWidth / 2) - 150,
                          top: 18,
                          child: const Polaroid(
                            imagePath: 'assets/images/arjun_camera.jpg',
                            width: 135,
                            height: 185,
                            rotation: 0.08,
                            isPolaroid: true,
                            tapePlacement: TapePlacement.topCenter,
                            tapeRotation: 0.12,
                            elevation: 10,
                          ),
                        ).animate().fadeIn(delay: 300.ms).slideX(begin: 0.1, end: 0),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Subtitle row flanked by Sparkle and Spider doodles
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SparkleDoodle(size: 22, color: AppColors.nearBlack),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "you both want",
                                style: AppTextStyles.bodySans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.nearBlack.withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "spider-man tonight",
                                style: AppTextStyles.bodySans(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.nearBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SpiderDoodle(size: 22, color: AppColors.nearBlack),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 32),

                  // Action Button: "start talking" with Pink Doodle Underline
                  HandwrittenPillButton(
                    text: "start talking",
                    width: 210,
                    height: 48,
                    showPinkUnderline: true,
                    fontSize: 21,
                    onPressed: () {
                      ref.read(activeBottomNavIndexProvider.notifier).state = 3;
                      context.go('/vibes');
                    },
                  ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 14),

                  // "maybe later" Text Link
                  GestureDetector(
                    onTap: () {
                      ref.read(activeBottomNavIndexProvider.notifier).state = 0;
                      context.go('/home');
                    },
                    child: Text(
                      "maybe later",
                      style: AppTextStyles.handwritten(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.nearBlack.withValues(alpha: 0.6),
                      ),
                    ),
                  ).animate().fadeIn(delay: 600.ms),

                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
