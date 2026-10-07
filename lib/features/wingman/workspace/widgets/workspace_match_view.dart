import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/torn_paper.dart';
import '../../../../shared/widgets/tape_strip.dart';
import '../../../home/widgets/friend_stack.dart';
import '../models/workspace_extended_data.dart';
import '../utils/wingman_action_handler.dart';

/// Screen 2 (Right): MATCH
/// Features:
/// - Header "it's a match!" with pink heart doodle and "wingmen made it happen"
/// - Filter pills: "all matches", "upcoming", "past" (interactive active state toggle)
/// - Match cards: Pair of polaroids with tape, names, date details, and colored "chat 💬" button
/// - Anonymous blind-date card with silhouette portraits and pink '?'
/// - Every interactive element wrapped with [WingmanInteractive] and assigned unique stable ID
class WorkspaceMatchView extends StatefulWidget {
  final VoidCallback? onBack;

  const WorkspaceMatchView({
    super.key,
    this.onBack,
  });

  @override
  State<WorkspaceMatchView> createState() => _WorkspaceMatchViewState();
}

class _WorkspaceMatchViewState extends State<WorkspaceMatchView> {
  String _activeFilter = 'all'; // 'all', 'upcoming', 'past'

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Bar: "it's a match!" + Pink Heart Doodle & FriendStack
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onBack,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "it's a match!",
                            style: GoogleFonts.kalam(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColors.nearBlack,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Pink heart doodle
                          Transform.rotate(
                            angle: 0.12,
                            child: const Icon(
                              Icons.favorite_border_rounded,
                              size: 22,
                              color: AppColors.pink,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            bottom: 1,
                            left: 0,
                            width: 60,
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppColors.lime,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Text(
                            "wingmen made it happen",
                            style: AppTextStyles.handwritten(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF625C52),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: widget.onBack,
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

          const SizedBox(height: 20),

          // 2. Filter Pills Row: "all matches", "upcoming", "past"
          Row(
            children: [
              _buildFilterPill(
                id: 'wm-match-filter-all',
                label: 'all matches',
                filterKey: 'all',
              ),
              const SizedBox(width: 8),
              _buildFilterPill(
                id: 'wm-match-filter-upcoming',
                label: 'upcoming',
                filterKey: 'upcoming',
              ),
              const SizedBox(width: 8),
              _buildFilterPill(
                id: 'wm-match-filter-past',
                label: 'past',
                filterKey: 'past',
              ),
            ],
          ),

          const SizedBox(height: 18),

          // 3. Match Cards List
          for (final match in WorkspaceExtendedMockData.matches) ...[
            _MatchCardWidget(match: match),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }

  Widget _buildFilterPill({
    required String id,
    required String label,
    required String filterKey,
  }) {
    final isSelected = _activeFilter == filterKey;

    return WingmanInteractive(
      id: id,
      customOnTap: () {
        setState(() => _activeFilter = filterKey);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.nearBlack : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: GoogleFonts.ibmPlexSans(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.cream : AppColors.nearBlack,
          ),
        ),
      ),
    );
  }
}

/// An individual match card featuring a pair of polaroids, details, and chat button
class _MatchCardWidget extends StatelessWidget {
  final MatchCardData match;

  const _MatchCardWidget({required this.match});

  @override
  Widget build(BuildContext context) {
    return WingmanInteractive(
      id: match.cardId,
      child: TornPaper(
        color: AppColors.creamLight,
        edges: TornEdges.all,
        seed: match.id.hashCode % 100,
        tearDepth: 3.5,
        elevation: 4,
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 14),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Row: Dual Polaroids side by side with heart or '?' between them
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Left Polaroid
                _PolaroidItem(
                  candidate: match.person1,
                  rotation: -0.04,
                ),

                // Center Doodle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: match.isAnonymous
                      ? Text(
                          "?",
                          style: GoogleFonts.caveat(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: AppColors.pink,
                          ),
                        )
                      : const Icon(
                          Icons.favorite_border_rounded,
                          size: 26,
                          color: AppColors.pink,
                        ),
                ),

                // Right Polaroid
                _PolaroidItem(
                  candidate: match.person2,
                  rotation: 0.04,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bottom Row: Date Title & Time + "chat 💬" button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Date details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      match.dateTitle,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.nearBlack,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      match.dateTime,
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B655C),
                      ),
                    ),
                  ],
                ),

                // Chat button with unique ID
                WingmanInteractive(
                  id: match.chatId,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                    decoration: BoxDecoration(
                      color: match.chatButtonColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(1, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "chat",
                          style: GoogleFonts.caveat(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.nearBlack,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 15,
                          color: AppColors.nearBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A polaroid frame with top tape strip and bottom name label
class _PolaroidItem extends StatelessWidget {
  final MatchCandidateItem candidate;
  final double rotation;

  const _PolaroidItem({
    required this.candidate,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // Polaroid Frame
              Container(
                width: 98,
                padding: const EdgeInsets.fromLTRB(5, 6, 5, 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 6,
                      offset: const Offset(1, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Container(
                    width: 88,
                    height: 94,
                    color: candidate.isAnonymous ? const Color(0xFF333333) : Colors.black12,
                    child: candidate.isAnonymous
                        ? Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                candidate.imagePath,
                                fit: BoxFit.cover,
                                color: Colors.black.withValues(alpha: 0.88),
                                colorBlendMode: BlendMode.srcOver,
                              ),
                              const Center(
                                child: Icon(
                                  Icons.person_rounded,
                                  size: 42,
                                  color: Colors.white24,
                                ),
                              ),
                            ],
                          )
                        : Image.asset(
                            candidate.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFFD4C9BC),
                              child: const Icon(Icons.person, color: Colors.black38),
                            ),
                          ),
                  ),
                ),
              ),

              // Translucent Tape Strip on top center of the polaroid
              const Positioned(
                top: -8,
                child: TapeStrip(
                  width: 44,
                  height: 16,
                  rotation: -0.05,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Name & Age (or placeholder for anonymous)
          if (!candidate.isAnonymous)
            Text(
              "${candidate.name}, ${candidate.age}",
              style: GoogleFonts.barlowCondensed(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.nearBlack,
                letterSpacing: 0.4,
              ),
            )
          else
            const SizedBox(height: 14),
        ],
      ),
    );
  }
}
