import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/torn_paper.dart';
import '../../../../shared/widgets/tape_strip.dart';
import '../../../../shared/widgets/polaroid.dart';
import '../../../../shared/widgets/sticker_badge.dart';
import '../models/workspace_data.dart';

/// The central scrapbook / collage hero stage from the "For you, by your people" screen.
/// Accurately reproduces:
/// - Large torn-paper B&W photo
/// - Tilted polaroid with tape (sunset palms)
/// - Vinyl record photo scrap
/// - Small black "+" button
/// - Lime green "her vibe" sticker
/// - Black torn-paper profile card (name, age, tags)
class WorkspaceHeroCollage extends StatelessWidget {
  final WorkspaceCandidateProfile profile;

  const WorkspaceHeroCollage({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. Main Hero Portrait (B&W photo with torn bottom & right edge)
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
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFDCD2C4),
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, size: 70, color: Colors.black26),
                ),
              ),
              // Subtle gradient shadow at bottom for high text contrast
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

        // 2. Translucent Tape Strip on top center of Hero photo
        const Positioned(
          top: -8,
          left: 130,
          child: TapeStrip(
            width: 65,
            height: 22,
            rotation: -0.06,
          ),
        ),

        // 3. Overlapping Polaroid of sunset palms (top right)
        Positioned(
          top: -6,
          right: -4,
          child: Polaroid(
            imagePath: profile.secondaryPhoto,
            width: 115,
            height: 125,
            rotation: 0.08,
            isPolaroid: true,
            tapePlacement: TapePlacement.topLeft,
            tapeRotation: 0.25,
            elevation: 8,
          ),
        ),

        // 4. Overlapping Vinyl Record Photo Scrap (below polaroid)
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
                  profile.vinylPhoto,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.black12,
                    child: const Icon(Icons.album, color: Colors.black38),
                  ),
                ),
              ),
            ),
          ),
        ),

        // 5. Floating Circular Black "+" button (next to vinyl)
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

        // 6. Lime Circular "her vibe" Sticker (overlapping bottom-left of hero photo)
        Positioned(
          bottom: 25,
          left: 6,
          child: StickerBadge.herVibe(size: 64, rotation: -0.15),
        ),

        // 7. Overlapping Black Torn-Paper Info Card ("SARA, 20" + tags)
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
        ),
      ],
    );
  }
}
