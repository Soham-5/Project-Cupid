import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/torn_paper.dart';
import '../../../../shared/widgets/tape_strip.dart';
import '../../../../shared/widgets/sticker_badge.dart';
import '../../../home/widgets/friend_stack.dart';
import '../models/workspace_extended_data.dart';
import '../utils/wingman_action_handler.dart';

/// Screen 3: PROFILE
/// Features:
/// - Back arrow top-left (navigates back to main user profile)
/// - Title "[NAME]'S PROFILE" with "you're his wingman" and crown/sparkle doodles
/// - Top Arjun profile card (polaroid + black torn info card + "looking for" note)
///   Tapping this card exits the Wingman workspace and returns to the user's main profile page!
/// - "other people you're wingman for" list (MEHAK, ROHAN, ISHA with active/paused tags)
/// - "+ add someone" button and dashed "add new person" row
/// - Every interactive element wrapped with [WingmanInteractive] and assigned unique stable ID
class WorkspaceProfileView extends StatelessWidget {
  final VoidCallback onExitToMainProfile;

  const WorkspaceProfileView({
    super.key,
    required this.onExitToMainProfile,
  });

  @override
  Widget build(BuildContext context) {
    const profile = WorkspaceExtendedMockData.arjunProfile;
    const otherFriends = WorkspaceExtendedMockData.otherFriends;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Bar: Back Arrow, Title with Doodles, and Avatar Stack
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Arrow with unique ID
              WingmanInteractive(
                id: 'wm-profile-back-arrow',
                customOnTap: onExitToMainProfile,
                child: const Padding(
                  padding: EdgeInsets.only(top: 4, right: 6, bottom: 6),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 25,
                    color: AppColors.nearBlack,
                  ),
                ),
              ),

              // Title "[NAME]'S PROFILE" with Crown & Highlight
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Crown doodle on top-left of title
                        Positioned(
                          top: -14,
                          left: 10,
                          child: Transform.rotate(
                            angle: -0.18,
                            child: const Text(
                              "👑",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        // Sparkle doodle on top-right of title
                        Positioned(
                          top: -6,
                          right: 12,
                          child: Text(
                            "⊹",
                            style: GoogleFonts.ibmPlexSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.nearBlack.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                        // Title Text with lime underline
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              bottom: 2,
                              left: -4,
                              right: -4,
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: AppColors.lime.withValues(alpha: 0.85),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                            Text(
                              "${profile.name}'S PROFILE",
                              style: GoogleFonts.barlowCondensed(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                                color: AppColors.nearBlack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // Subtitle: "you're his wingman" with purple pill
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "you're his ",
                          style: AppTextStyles.handwritten(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF625C52),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.lavender.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            "wingman",
                            style: AppTextStyles.handwritten(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.nearBlack,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Avatar cluster
              const FriendStack(
                avatars: [
                  'assets/images/friend_1.jpg',
                  'assets/images/friend_2.jpg',
                ],
                count: 3,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 2. Top Arjun Profile Card (Interactive: tapping exits back to main user profile!)
          WingmanInteractive(
            id: 'wm-profile-top-card',
            customOnTap: onExitToMainProfile,
            child: _TopHostProfileCard(profile: profile),
          ),

          const SizedBox(height: 24),

          // 3. Section: "other people you're wingman for ⤵" + "+ add someone"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "other people you're wingman for",
                        style: GoogleFonts.caveat(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.nearBlack,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text("⤵", style: TextStyle(fontSize: 14, color: AppColors.nearBlack)),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // "+ add someone" button
              WingmanInteractive(
                id: 'wm-profile-add-someone-btn',
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.nearBlack,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "+",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.stickyYellow,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "add someone",
                        style: GoogleFonts.caveat(
                          fontSize: 14,
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

          const SizedBox(height: 12),

          // 4. Other People Cards List
          for (final friend in otherFriends) ...[
            _OtherFriendCard(friend: friend),
            const SizedBox(height: 10),
          ],

          // 5. Dashed "add new person" Row
          WingmanInteractive(
            id: 'wm-profile-add-new-person',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.creamLight.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.nearBlack.withValues(alpha: 0.22),
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.nearBlack.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.add, size: 18, color: AppColors.nearBlack),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "add new person",
                          style: GoogleFonts.caveat(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.nearBlack,
                          ),
                        ),
                        Text(
                          "be their wingman",
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF625C52),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.group_outlined,
                    size: 19,
                    color: Color(0xFF625C52),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: AppColors.nearBlack,
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

/// The top scrapbook card for Arjun with polaroid, black info card, and "looking for" note
class _TopHostProfileCard extends StatelessWidget {
  final WorkspaceHostProfile profile;

  const _TopHostProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Cream Scrapbook Paper
        Container(
          padding: const EdgeInsets.fromLTRB(10, 14, 10, 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF8F2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left: Large Tilted Polaroid of Arjun with Tape and Starburst Badge
                  Transform.rotate(
                    angle: -0.04,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Polaroid Frame
                        Container(
                          width: 130,
                          padding: const EdgeInsets.fromLTRB(7, 8, 7, 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.16),
                                blurRadius: 6,
                                offset: const Offset(1, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.asset(
                              profile.photoPath,
                              width: 116,
                              height: 128,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Translucent Tape Strip on top-left
                        const Positioned(
                          top: -8,
                          left: 10,
                          child: TapeStrip(
                            width: 50,
                            height: 18,
                            rotation: -0.15,
                          ),
                        ),

                        // Paperclip on left side
                        Positioned(
                          top: 26,
                          left: -6,
                          child: Transform.rotate(
                            angle: -0.2,
                            child: Container(
                              width: 12,
                              height: 28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFF8F887B),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Lavender Starburst sticker with 'A' at bottom-left
                        Positioned(
                          bottom: -6,
                          left: -8,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const StickerBadge(
                                type: StickerType.starburst,
                                size: 36,
                                backgroundColor: AppColors.lavender,
                              ),
                              Text(
                                "A",
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.nearBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Right: Black Torn-Paper Info Card
                  Expanded(
                    child: TornPaper(
                      color: AppColors.cardDark,
                      edges: TornEdges.all,
                      seed: 72,
                      tearDepth: 3.5,
                      elevation: 6,
                      padding: const EdgeInsets.fromLTRB(14, 12, 10, 14),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${profile.name}, ${profile.age}",
                                style: GoogleFonts.barlowCondensed(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.cream,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              const SizedBox(height: 6),
                              for (final tag in profile.bioTags)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2.5),
                                  child: Text(
                                    tag,
                                    style: AppTextStyles.bodySans(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.cream.withValues(alpha: 0.88),
                                    ).copyWith(height: 1.15),
                                  ),
                                ),
                            ],
                          ),

                          // Lime Smiley Face in bottom-right of black card
                          Positioned(
                            bottom: -2,
                            right: 0,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.lime, width: 2),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "☺",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.lime,
                                  height: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Bottom Torn Paper "looking for" Note
              TornPaper(
                color: AppColors.creamLight,
                edges: const TornEdges(top: true, bottom: true),
                seed: 28,
                tearDepth: 2.5,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "looking for",
                            style: GoogleFonts.caveat(
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF625C52),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            profile.lookingForText,
                            style: GoogleFonts.caveat(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.nearBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Pink heart doodle
                    const Icon(
                      Icons.favorite_border_rounded,
                      size: 22,
                      color: AppColors.pink,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// An individual card for another person the user is wingman for
class _OtherFriendCard extends StatelessWidget {
  final WorkspaceOtherFriend friend;

  const _OtherFriendCard({required this.friend});

  @override
  Widget build(BuildContext context) {
    return WingmanInteractive(
      id: friend.elementId,
      child: TornPaper(
        color: AppColors.creamLight,
        edges: TornEdges.all,
        seed: friend.id.hashCode % 100,
        tearDepth: 2.5,
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        child: Row(
          children: [
            // Left: Photo with Top Tape
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    friend.photoPath,
                    width: 58,
                    height: 58,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: -5,
                  left: 6,
                  child: TapeStrip(
                    width: 32,
                    height: 12,
                    color: friend.status == 'active'
                        ? AppColors.lavender.withValues(alpha: 0.6)
                        : AppColors.lime.withValues(alpha: 0.6),
                    rotation: -0.1,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            // Initial Badge
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: friend.initialBadgeColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                friend.initial,
                style: GoogleFonts.barlowCondensed(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.nearBlack,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Name, Subtitle, and Status Badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${friend.name}, ${friend.age}",
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    friend.subtitle,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF625C52),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: friend.statusBadgeColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      friend.status,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.nearBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Doodles / Chevron
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (friend.id == 'mehak')
                  const Text("♡♡", style: TextStyle(fontSize: 14, color: AppColors.pink))
                else if (friend.id == 'rohan')
                  const Text("☆", style: TextStyle(fontSize: 15, color: AppColors.nearBlack))
                else if (friend.id == 'isha')
                  const Text("☺", style: TextStyle(fontSize: 15, color: AppColors.lavender)),
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 22,
                  color: AppColors.nearBlack,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
