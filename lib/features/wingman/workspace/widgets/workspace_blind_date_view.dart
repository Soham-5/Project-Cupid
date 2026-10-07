import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/torn_paper.dart';
import '../../../../shared/widgets/sticker_badge.dart';
import '../../../home/widgets/friend_stack.dart';
import '../models/workspace_extended_data.dart';
import '../utils/wingman_action_handler.dart';

/// Screen 1 (Left): BLIND DATE
/// Features:
/// - Header "blind date" with doodle hands + heart and "set up something real"
/// - "upcoming events" list of torn-paper cards (Movie Night, Cafe Hangout, Art Exhibit)
/// - Starburst stickers on each photo
/// - "create your own" section with black torn-paper "+ post a plan" button
/// - Every interactive element wrapped with [WingmanInteractive] and assigned unique stable ID
class WorkspaceBlindDateView extends StatelessWidget {
  final VoidCallback? onBack;

  const WorkspaceBlindDateView({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Bar: "blind date" + hands heart doodle & FriendStack
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onBack,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                bottom: 2,
                                left: 0,
                                right: 18,
                                child: Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.lime.withValues(alpha: 0.85),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              Text(
                                "blind date",
                                style: GoogleFonts.kalam(
                                  fontSize: 31,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.nearBlack,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          // Cute hands & pink heart doodle
                          const _HandsHeartDoodle(),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "set up something real",
                        style: AppTextStyles.handwritten(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF625C52),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onBack,
                behavior: HitTestBehavior.opaque,
                child: const FriendStack(
                  avatars: [
                    'assets/images/friend_1.jpg',
                    'assets/images/friend_2.jpg',
                  ],
                  count: 3,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // 2. Section Header: "upcoming events ⊹"
          Row(
            children: [
              Text(
                "upcoming events",
                style: GoogleFonts.kalam(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                "⊹",
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 3. Upcoming Events Cards List
          for (int i = 0; i < WorkspaceExtendedMockData.blindDateEvents.length; i++) ...[
            _BlindDateEventCard(
              event: WorkspaceExtendedMockData.blindDateEvents[i],
              showPaperclip: i == 0,
            ),
            const SizedBox(height: 14),
          ],

          const SizedBox(height: 16),

          // 4. Section: "create your own ⊹"
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.lime.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    "create your own",
                    style: GoogleFonts.caveat(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.nearBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              Text(
                "⊹",
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 5. Black Torn-Paper Banner: "+ post a plan"
          WingmanInteractive(
            id: 'wm-blind-post-plan-btn',
            child: TornPaper(
              color: AppColors.cardDark,
              edges: TornEdges.all,
              seed: 58,
              tearDepth: 3.5,
              elevation: 4,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "+",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.lime,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "post a plan",
                    style: GoogleFonts.caveat(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.cream,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// An individual torn-paper card for a blind date event
class _BlindDateEventCard extends StatelessWidget {
  final BlindDateEvent event;
  final bool showPaperclip;

  const _BlindDateEventCard({
    required this.event,
    this.showPaperclip = false,
  });

  @override
  Widget build(BuildContext context) {
    return WingmanInteractive(
      id: event.cardId,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TornPaper(
            color: AppColors.creamLight,
            edges: TornEdges.all,
            seed: event.title.hashCode % 100,
            tearDepth: 3.0,
            elevation: 4,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Photo Scrap with Starburst Sticker
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 108,
                        height: 98,
                        color: Colors.black12,
                        child: Image.asset(
                          event.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFFD4C9BC),
                            child: const Icon(Icons.event, color: Colors.black38),
                          ),
                        ),
                      ),
                    ),
                    // Starburst Sticker at top-left
                    Positioned(
                      top: -6,
                      left: -6,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          StickerBadge(
                            type: StickerType.starburst,
                            size: 34,
                            backgroundColor: event.badgeColor,
                          ),
                          const Icon(
                            Icons.star_border_rounded,
                            size: 16,
                            color: AppColors.nearBlack,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 14),

                // Right Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: GoogleFonts.barlowCondensed(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: AppColors.nearBlack,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        event.time,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF423E37),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        event.lookingFor,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF756F64),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Interactive "wingmans interested" sub-element
                      WingmanInteractive(
                        id: event.interestedId,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_outline_rounded,
                              size: 15,
                              color: AppColors.nearBlack,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              "${event.wingmansInterested} wingmans interested",
                              style: GoogleFonts.ibmPlexSans(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.nearBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Paperclip graphic on top right of the first card
          if (showPaperclip)
            Positioned(
              top: -8,
              right: 18,
              child: Transform.rotate(
                angle: 0.28,
                child: Container(
                  width: 16,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF9E9589),
                      width: 2.2,
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

/// A subtle hand-drawn doodle of hands with a pink heart
class _HandsHeartDoodle extends StatelessWidget {
  const _HandsHeartDoodle();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pink heart
          Positioned(
            top: 0,
            child: Icon(
              Icons.favorite_border_rounded,
              size: 16,
              color: AppColors.pink,
            ),
          ),
          // Hands gesture lines
          Positioned(
            bottom: 0,
            left: 4,
            child: Text(
              "╰",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.nearBlack.withValues(alpha: 0.8),
                height: 1.0,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: Text(
              "╯",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.nearBlack.withValues(alpha: 0.8),
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
