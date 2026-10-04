import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/torn_paper.dart';
import '../../shared/widgets/tape_strip.dart';
import '../../shared/widgets/polaroid.dart';
import '../../shared/widgets/sticker_badge.dart';
import '../../data/repositories/mock_dating_repository.dart';
import 'widgets/friend_stack.dart';
import 'widgets/plan_idea_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(saraProfileProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 480 ? 440.0 : screenWidth;

    return Scaffold(
      backgroundColor: AppColors.cream,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Top Bar: Handwritten Title & Curator Avatar Stack
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "For you,\nby your people",
                            style: AppTextStyles.handwritten(
                              fontSize: 27,
                              fontWeight: FontWeight.w700,
                              color: AppColors.nearBlack,
                            ).copyWith(height: 1.05),
                          ),
                        ),
                        const SizedBox(width: 12),
                        FriendStack(
                          avatars: profile.friendAvatars,
                          count: profile.friendCount,
                        ),
                      ],
                    ).animate().fadeIn(duration: 350.ms).slideY(begin: -0.1, end: 0),

                    const SizedBox(height: 16),

                    // Central Collage Stage
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Main Hero Portrait (B&W photo with torn bottom edge)
                        TornPaper(
                          color: AppColors.creamLight,
                          edges: const TornEdges(bottom: true, right: true),
                          seed: 12,
                          tearDepth: 5.0,
                          elevation: 6,
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          height: 380,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                profile.heroPhoto,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              ),
                              // Subtle vignette at the bottom for contrast
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 80,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.35),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Translucent Tape Strip on top center of Hero photo
                        const Positioned(
                          top: -8,
                          left: 130,
                          child: TapeStrip(
                            width: 65,
                            height: 22,
                            rotation: -0.06,
                          ),
                        ),

                        // Overlapping Polaroid of sunset palms (top right)
                        Positioned(
                          top: -6,
                          right: -4,
                          child: Polaroid(
                            imagePath: profile.secondaryPhoto ?? 'assets/images/sunset_palms.jpg',
                            width: 115,
                            height: 125,
                            rotation: 0.08,
                            isPolaroid: true,
                            tapePlacement: TapePlacement.topLeft,
                            tapeRotation: 0.25,
                            elevation: 8,
                          ),
                        ).animate().fadeIn(delay: 150.ms).scale(begin: const Offset(0.9, 0.9)),

                        // Overlapping Vinyl Record Photo Scrap (below polaroid)
                        Positioned(
                          top: 130,
                          right: 12,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.22),
                                  blurRadius: 6,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                width: 78,
                                height: 78,
                                color: AppColors.creamLight,
                                padding: const EdgeInsets.all(3),
                                child: Image.asset(
                                  profile.vinylPhoto ?? 'assets/images/vinyl_record.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(delay: 250.ms).slideX(begin: 0.1, end: 0),

                        // Floating Circular Black "+" button (next to vinyl)
                        Positioned(
                          top: 218,
                          right: 38,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.nearBlack,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.cream,
                              size: 18,
                            ),
                          ),
                        ),

                        // Lime Circular "her vibe" Sticker (overlapping bottom-left of hero photo)
                        Positioned(
                          bottom: 25,
                          left: 6,
                          child: StickerBadge.herVibe(size: 64, rotation: -0.15),
                        ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.7, 0.7)),

                        // Overlapping Black Torn-Paper Info Card ("SARA, 20" + tags)
                        Positioned(
                          bottom: -28,
                          right: 8,
                          child: TornPaper(
                            color: AppColors.cardDark,
                            edges: TornEdges.all,
                            seed: 45,
                            tearDepth: 4.0,
                            elevation: 8,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            width: 195,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${profile.name}, ${profile.age}",
                                  style: AppTextStyles.markerHeading(
                                    fontSize: 22,
                                    color: AppColors.cream,
                                    letterSpacing: 0.8,
                                  ).copyWith(height: 1.0),
                                ),
                                const SizedBox(height: 6),
                                for (final tag in profile.tags)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      tag,
                                      style: AppTextStyles.bodySans(
                                        fontSize: 12.5,
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

                    const SizedBox(height: 48),

                    // Purple Torn "Plan idea" Card ("SPIDER-MAN TONIGHT?")
                    PlanIdeaCard(
                      title: profile.planIdea.title,
                      subtitle: profile.planIdea.subtitle,
                      onMaybeTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.cardDark,
                            content: Text(
                              "Saved for later!",
                              style: AppTextStyles.handwritten(color: AppColors.cream, fontSize: 18),
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      onLetsGoTap: () {
                        // Switch tab to match screen with celebration!
                        ref.read(activeBottomNavIndexProvider.notifier).state = 2;
                        context.go('/match');
                      },
                    ).animate().fadeIn(delay: 350.ms).slideY(begin: 0.12, end: 0),

                    const SizedBox(height: 36),
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
