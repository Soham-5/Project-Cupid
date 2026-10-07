import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/repositories/mock_dating_repository.dart';
import '../../../home/widgets/friend_stack.dart';
import '../../wingman_config.dart';
import '../models/workspace_data.dart';
import '../widgets/workspace_action_buttons.dart';
import '../widgets/workspace_blind_date_view.dart';
import '../widgets/workspace_bottom_nav.dart';
import '../widgets/workspace_hero_collage.dart';
import '../widgets/workspace_match_view.dart';
import '../widgets/workspace_profile_view.dart';
import '../widgets/workspace_vibes_view.dart';

/// The full-screen Wingman Workspace container for a friend (e.g. ARJUN, MEHAK, ROHAN).
/// Features:
/// - Isolated bottom navigation bar (home, blind date, match, vibes, profile)
/// - Tab switching with quick 180ms fade animation
/// - Home: Scrapbook collage, hero photo, tilted polaroids, like/dislike buttons
/// - Blind Date: Upcoming events list, starburst stickers, "+ post a plan" button
/// - Match: Pair polaroids with dates, filter pills, "chat 💬" buttons, anonymous card
/// - Profile: Arjun's profile card, other people list with active/paused tags
///   Tapping the top profile card or back arrow exits back to the main user profile ("you" tab)
///   using the reverse slide animation.
class WingmanWorkspaceScreen extends ConsumerStatefulWidget {
  final WorkspaceFriendSummary friend;
  final int initialTabIndex;

  const WingmanWorkspaceScreen({
    super.key,
    required this.friend,
    this.initialTabIndex = 0,
  });

  @override
  ConsumerState<WingmanWorkspaceScreen> createState() => _WingmanWorkspaceScreenState();
}

class _WingmanWorkspaceScreenState extends ConsumerState<WingmanWorkspaceScreen> {
  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex;
  }

  void _exitToMainProfile() {
    // 1. Pop the workspace route to trigger the reverse slide-out animation
    Navigator.of(context).pop();

    // 2. Set the shell bottom navigation index to the user profile ("you") tab
    final profileIndex = WingmanConfig.enabled ? 5 : 4;
    ref.read(activeBottomNavIndexProvider.notifier).state = profileIndex;

    // 3. Switch router location to /profile
    context.go('/profile');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          bottom: false,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _buildCurrentTabContent(),
          ),
        ),
        bottomNavigationBar: WorkspaceBottomNav(
          currentIndex: _currentTabIndex,
          onTabSelected: (index) {
            setState(() => _currentTabIndex = index);
          },
        ),
      ),
    );
  }

  Widget _buildCurrentTabContent() {
    switch (_currentTabIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return WorkspaceBlindDateView(
          key: const ValueKey('tab_blind_date'),
          onBack: () => Navigator.of(context).pop(),
        );
      case 2:
        return WorkspaceMatchView(
          key: const ValueKey('tab_match'),
          onBack: () => Navigator.of(context).pop(),
        );
      case 3:
        return WorkspaceVibesView(
          key: const ValueKey('tab_vibes'),
          onBack: () => Navigator.of(context).pop(),
        );
      case 4:
        return WorkspaceProfileView(
          key: const ValueKey('tab_profile'),
          onExitToMainProfile: _exitToMainProfile,
        );
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    final candidate = widget.friend.candidate;
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 480 ? 440.0 : screenWidth;

    return SingleChildScrollView(
      key: const ValueKey('tab_home'),
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
                    // Tappable header area with back action to wingman people page
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          "For you,\nby your people",
                          style: AppTextStyles.handwritten(
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                            color: AppColors.nearBlack,
                          ).copyWith(height: 1.05),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Avatar cluster at top right
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      behavior: HitTestBehavior.opaque,
                      child: FriendStack(
                        avatars: candidate.curatorAvatars,
                        count: candidate.curatorCount,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Central Collage Stage (Sara 20 Scrapbook)
                WorkspaceHeroCollage(profile: candidate),

                // Space for the overlapping black card and action buttons
                const SizedBox(height: 52),

                // Action Buttons: [dislike] and [like]
                const Center(
                  child: WorkspaceActionButtons(),
                ),

                const SizedBox(height: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
