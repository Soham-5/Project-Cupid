import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/torn_paper.dart';
import '../../../shared/widgets/tape_strip.dart';
import '../../../shared/widgets/sticker_badge.dart';
import '../../../shared/widgets/micro_doodles.dart';
import '../../../data/models/plan_model.dart';

class PlanCardWidget extends StatelessWidget {
  final Plan plan;
  final VoidCallback? onTap;

  const PlanCardWidget({
    super.key,
    required this.plan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    switch (plan.style) {
      case PlanCardStyle.darkSpiderman:
        return _buildSpidermanCard(context);
      case PlanCardStyle.creamCafe:
        return _buildCafeCard(context);
      case PlanCardStyle.darkOutlinedDrive:
        return _buildDriveCard(context);
      case PlanCardStyle.creamArtExhibit:
        return _buildArtExhibitCard(context);
    }
  }

  // 1. SPIDER-MAN TONIGHT: Photo left, dark torn card, starburst sticker
  Widget _buildSpidermanCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TornPaper(
            color: AppColors.cardDark,
            edges: TornEdges.all,
            seed: 23,
            tearDepth: 4.0,
            elevation: 6,
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                // Left Photo
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2),
                  ),
                  child: SizedBox(
                    width: 130,
                    height: 100,
                    child: Image.asset(
                      plan.photoPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Right Cream Torn Paper Section with details
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    color: AppColors.cream,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          plan.title,
                          style: AppTextStyles.markerHeading(
                            fontSize: 18,
                            color: AppColors.nearBlack,
                          ).copyWith(height: 1.05),
                        ),
                        const SizedBox(height: 8),
                        _buildAttendeesRow(plan.attendeesCount, plan.attendeeAvatars, AppColors.nearBlack),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Lavender/Pink Starburst sticker on left photo edge
          Positioned(
            top: 12,
            left: -10,
            child: StickerBadge.starburst(
              size: 38,
              color: AppColors.lavender,
              rotation: -0.15,
            ),
          ),
          Positioned(
            bottom: 4,
            left: 112,
            child: StickerBadge.starburst(
              size: 26,
              color: AppColors.pink,
              rotation: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // 2. CAFE HANGOUT: Cream torn card, photo right, top tape
  Widget _buildCafeCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TornPaper(
            color: AppColors.cream,
            edges: TornEdges.all,
            seed: 67,
            tearDepth: 4.5,
            elevation: 6,
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                // Left Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          plan.title,
                          style: AppTextStyles.markerHeading(
                            fontSize: 19,
                            color: AppColors.nearBlack,
                          ).copyWith(height: 1.05),
                        ),
                        const SizedBox(height: 8),
                        _buildAttendeesRow(plan.attendeesCount, plan.attendeeAvatars, AppColors.nearBlack),
                      ],
                    ),
                  ),
                ),
                // Right Photo
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  child: SizedBox(
                    width: 140,
                    height: 100,
                    child: Image.asset(
                      plan.photoPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Translucent Tape on top right
          const Positioned(
            top: -6,
            right: 18,
            child: TapeStrip(width: 48, height: 16, rotation: -0.08),
          ),
        ],
      ),
    );
  }

  // 3. LATE NIGHT DRIVE: Dark outlined card, sunset road photo left, moon doodle
  Widget _buildDriveCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.22), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left Photo
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                bottomLeft: Radius.circular(9),
              ),
              child: SizedBox(
                width: 135,
                height: 95,
                child: Image.asset(
                  plan.photoPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Right Details with Moon doodle
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan.title,
                          style: AppTextStyles.markerHeading(
                            fontSize: 18,
                            color: AppColors.cream,
                          ).copyWith(height: 1.05),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: MoonDoodle(size: 22, color: AppColors.lime),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildAttendeesRow(plan.attendeesCount, plan.attendeeAvatars, AppColors.cream),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4. ART EXHIBIT THIS WEEKEND: Cream card, gallery photo right, pink heart doodle
  Widget _buildArtExhibitCard(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TornPaper(
            color: AppColors.cream,
            edges: TornEdges.all,
            seed: 91,
            tearDepth: 4.0,
            elevation: 6,
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                // Left Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan.title,
                              style: AppTextStyles.markerHeading(
                                fontSize: 17,
                                color: AppColors.nearBlack,
                              ).copyWith(height: 1.05),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 2, right: 4),
                              child: HeartDoodle(size: 22, color: AppColors.pink),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _buildAttendeesRow(plan.attendeesCount, plan.attendeeAvatars, AppColors.nearBlack),
                      ],
                    ),
                  ),
                ),
                // Right Photo
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                  child: SizedBox(
                    width: 135,
                    height: 95,
                    child: Image.asset(
                      plan.photoPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendeesRow(int count, List<String> avatars, Color textColor) {
    return Row(
      children: [
        Text(
          '$count going',
          style: AppTextStyles.bodySans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColor.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 38,
          height: 18,
          child: Stack(
            children: [
              if (avatars.isNotEmpty)
                Positioned(
                  left: 0,
                  child: _MiniAvatar(imagePath: avatars[0]),
                ),
              if (avatars.length > 1)
                Positioned(
                  left: 12,
                  child: _MiniAvatar(imagePath: avatars[1]),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  final String imagePath;

  const _MiniAvatar({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.cream, width: 1.0),
      ),
      child: ClipOval(
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
