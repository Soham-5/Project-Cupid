import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/torn_paper.dart';
import '../../shared/widgets/tape_strip.dart';
import '../../shared/widgets/sticker_badge.dart';
import '../../data/repositories/mock_dating_repository.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(arjunProfileProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 480 ? 440.0 : screenWidth;

    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // Top Bar: Back Arrow & More Options
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColors.cream),
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              ref.read(activeBottomNavIndexProvider.notifier).state = 0;
                              context.go('/home');
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_horiz, color: AppColors.cream),
                          onPressed: () {},
                        ),
                      ],
                    ).animate().fadeIn(duration: 250.ms),

                    const SizedBox(height: 8),

                    // Main Collage: Arjun Portrait Scrap
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main B&W photo scrap with torn paper edges
                        TornPaper(
                          color: AppColors.creamLight,
                          edges: TornEdges.all,
                          seed: 77,
                          tearDepth: 5.0,
                          elevation: 10,
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          height: 480,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                profile.heroPhoto,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                              // Grayscale shading at bottom
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.4),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Translucent Tape Strip on top center of photo
                        const Positioned(
                          top: -10,
                          left: 140,
                          child: TapeStrip(
                            width: 70,
                            height: 22,
                            rotation: -0.04,
                          ),
                        ),

                        // Lime Smiley Sticker (overlapping bottom-left of hero photo)
                        Positioned(
                          bottom: 125,
                          left: -8,
                          child: StickerBadge.smiley(
                            size: 58,
                            rotation: -0.08,
                          ),
                        ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.7, 0.7)),

                        // Vinyl record photo scrap on lower left
                        Positioned(
                          bottom: 25,
                          left: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  blurRadius: 8,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                width: 85,
                                height: 85,
                                color: AppColors.creamLight,
                                padding: const EdgeInsets.all(3),
                                child: Image.asset(
                                  profile.vinylPhoto ?? 'assets/images/vinyl_record.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 250.ms).slideX(begin: -0.1, end: 0),

                        // Overlapping Black Torn Info Card ("ARJUN, 21" + tags)
                        Positioned(
                          bottom: -20,
                          right: 4,
                          child: TornPaper(
                            color: AppColors.cardDark,
                            edges: TornEdges.all,
                            seed: 52,
                            tearDepth: 4.5,
                            elevation: 9,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${profile.name}, ${profile.age}",
                                  style: AppTextStyles.markerHeading(
                                    fontSize: 23,
                                    color: AppColors.cream,
                                    letterSpacing: 0.8,
                                  ).copyWith(height: 1.0),
                                ),
                                const SizedBox(height: 8),
                                for (final tag in profile.tags)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Text(
                                      tag,
                                      style: AppTextStyles.bodySans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.cream.withValues(alpha: 0.88),
                                      ).copyWith(height: 1.15),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
                      ],
                    ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
