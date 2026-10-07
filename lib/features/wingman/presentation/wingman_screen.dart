import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../models/wingman_models.dart';
import '../widgets/wingman_candidate_card.dart';
import '../widgets/wingman_cutout_card.dart';
import '../widgets/wingman_friend_tile.dart';
import '../widgets/wingman_header.dart';
import '../workspace/wingman_workspace.dart';

enum WingmanSubScreen { home, people, swipe, done }

class WingmanScreen extends StatefulWidget {
  const WingmanScreen({super.key});

  @override
  State<WingmanScreen> createState() => _WingmanScreenState();
}

class _WingmanScreenState extends State<WingmanScreen> {
  WingmanSubScreen _currentScreen = WingmanSubScreen.home;
  WingmanSubScreen _returnScreen = WingmanSubScreen.home;

  late WingmanFriend _selectedFriend;
  int _candidateIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedFriend = WingmanMockData.friends.first;
  }

  void _navigateTo(WingmanSubScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  void _selectFriend(WingmanFriend friend) {
    setState(() {
      _selectedFriend = friend;
      _candidateIndex = 0;
      _returnScreen = _currentScreen == WingmanSubScreen.people
          ? WingmanSubScreen.people
          : WingmanSubScreen.home;
      _currentScreen = WingmanSubScreen.swipe;
    });
  }

  void _nextProfile({bool liked = false}) {
    setState(() {
      _candidateIndex++;
      if (_candidateIndex >= WingmanMockData.candidates.length) {
        _currentScreen = WingmanSubScreen.done;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: _buildCurrentSubScreen(),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSubScreen() {
    switch (_currentScreen) {
      case WingmanSubScreen.home:
        return _buildHomeScreen();
      case WingmanSubScreen.people:
        return _buildPeopleScreen();
      case WingmanSubScreen.swipe:
        return _buildSwipeScreen();
      case WingmanSubScreen.done:
        return _buildDoneScreen();
    }
  }

  Widget _buildWorkspaceFriendTile(
    WorkspaceFriendSummary friend, {
    bool showDivider = true,
  }) {
    return InkWell(
      onTap: () {
        WorkspaceSlideRoute.open(
          context,
          WingmanWorkspaceScreen(friend: friend),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.black.withValues(alpha: 0.04),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: showDivider
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.nearBlack.withValues(alpha: 0.14),
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            // Initial Badge
            Transform.rotate(
              angle: friend.badgeRotationDeg * (math.pi / 180),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: friend.badgeColor,
                    border: Border.all(color: AppColors.nearBlack, width: 2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    friend.initial,
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: AppColors.nearBlack,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Friend Name & Tags
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        friend.name,
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.nearBlack,
                        ),
                      ),
                      Text(
                        ', ${friend.age}',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.nearBlack,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  _buildHighlightedSubtitle(friend),
                ],
              ),
            ),

            // Arrow
            Transform.rotate(
              angle: -4 * (math.pi / 180),
              child: Text(
                '→',
                style: GoogleFonts.caveat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedSubtitle(WorkspaceFriendSummary friend) {
    if (friend.highlightedWord == null) {
      return Text(
        friend.subtitle,
        style: GoogleFonts.ibmPlexSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF625C52),
          height: 1.25,
        ),
      );
    }

    final parts = friend.subtitle.split(friend.highlightedWord!);
    return RichText(
      text: TextSpan(
        style: GoogleFonts.ibmPlexSans(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF625C52),
          height: 1.25,
        ),
        children: [
          TextSpan(text: parts[0]),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.lime,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                friend.highlightedWord!,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.nearBlack,
                ),
              ),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }

  // ==========================================
  // SCREEN 1: WINGMAN HOME (MISSION PICKER)
  // ==========================================
  Widget _buildHomeScreen() {
    return Column(
      key: const ValueKey('wingman_home'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WingmanHeader(),

        // Section Title
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'MY PEOPLE',
              style: GoogleFonts.barlowCondensed(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: AppColors.nearBlack,
              ),
            ),
            Text(
              'who you\'re wingman for',
              style: GoogleFonts.caveat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF625C52),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Main Mission Cutout Card
        WingmanCutoutCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Mission Top
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PICK A MISSION',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  Text(
                    'then find their person →',
                    style: GoogleFonts.caveat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF625C52),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Dashed divider line
              CustomPaint(
                size: const Size(double.infinity, 1),
                painter: _DashedLinePainter(
                  color: AppColors.nearBlack.withValues(alpha: 0.28),
                ),
              ),
              const SizedBox(height: 8),

              // Friend List
              ...List.generate(WorkspaceMockData.defaultFriends.length, (index) {
                final wf = WorkspaceMockData.defaultFriends[index];
                return _buildWorkspaceFriendTile(wf, showDivider: true);
              }),
              WingmanFriendTile(
                friend: WingmanMockData.friends.first,
                showDivider: false,
                onTap: () => _selectFriend(WingmanMockData.friends.first),
              ),

              const SizedBox(height: 10),

              // Note Strip: "choose a friend →" and "see all" button
              Container(
                padding: const EdgeInsets.only(top: 14),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.nearBlack.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'choose a friend →',
                      style: GoogleFonts.caveat(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF625C52),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _navigateTo(WingmanSubScreen.people),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.nearBlack,
                        foregroundColor: AppColors.cream,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      child: Text(
                        'see all',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.cream,
                        ),
                      ),
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

  // ==========================================
  // SCREEN 2: MY PEOPLE (ALL MISSIONS)
  // ==========================================
  Widget _buildPeopleScreen() {
    return Column(
      key: const ValueKey('wingman_people'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Back button
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => _navigateTo(WingmanSubScreen.home),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.nearBlack),
            label: Text(
              'Wingman',
              style: GoogleFonts.caveat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.nearBlack,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),

        Text(
          'My People',
          style: GoogleFonts.kalam(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: AppColors.nearBlack,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Friends who\'ve trusted you to be their wingman.',
          style: GoogleFonts.caveat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF625C52),
          ),
        ),
        const SizedBox(height: 18),

        // Cutout card with preferences
        WingmanCutoutCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'WHO ARE YOU WINGMAN FOR?',
                    style: GoogleFonts.barlowCondensed(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                      color: AppColors.nearBlack,
                    ),
                  ),
                  Text(
                    'your missions',
                    style: GoogleFonts.caveat(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF625C52),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...List.generate(WorkspaceMockData.defaultFriends.length, (index) {
                final wf = WorkspaceMockData.defaultFriends[index];
                return _buildWorkspaceFriendTile(wf, showDivider: true);
              }),
              ...List.generate(WingmanMockData.friends.length, (index) {
                final friend = WingmanMockData.friends[index];
                final isLast = index == WingmanMockData.friends.length - 1;
                return WingmanFriendTile(
                  friend: friend,
                  overrideSubtitle: friend.preference,
                  showDivider: !isLast,
                  onTap: () => _selectFriend(friend),
                );
              }),
            ],
          ),
        ),

        const SizedBox(height: 18),
        Center(
          child: Text(
            'tap a friend → find their person',
            style: GoogleFonts.caveat(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF625C52),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SCREEN 3: FIND THEIR PERSON (SCOUT / SWIPE)
  // ==========================================
  Widget _buildSwipeScreen() {
    final candidate = WingmanMockData.candidates[
        _candidateIndex % WingmanMockData.candidates.length];

    final backLabel = _returnScreen == WingmanSubScreen.people ? 'My People' : 'Wingman';

    return Column(
      key: const ValueKey('wingman_swipe'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Back Button
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () => _navigateTo(_returnScreen),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.nearBlack),
            label: Text(
              backLabel,
              style: GoogleFonts.caveat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.nearBlack,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),

        Text(
          'Find Their Person',
          style: GoogleFonts.kalam(
            fontSize: 34,
            fontWeight: FontWeight.w700,
            color: AppColors.nearBlack,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'blind-date scout · ${_selectedFriend.name}',
          style: GoogleFonts.caveat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF625C52),
          ),
        ),
        const SizedBox(height: 18),

        // Candidate Paper Card
        Center(
          child: WingmanCandidateCard(
            candidate: candidate,
          ),
        ),
        const SizedBox(height: 22),

        // Actions: [×] not their vibe? --- [♡] could work?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // No button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: -2.0 * (math.pi / 180),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _nextProfile(liked: false),
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F2E7),
                          border: Border.all(color: AppColors.nearBlack, width: 2),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '×',
                          style: GoogleFonts.ibmPlexSans(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.nearBlack,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'not their vibe?',
                  style: GoogleFonts.caveat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF625C52),
                  ),
                ),
              ],
            ),

            // Yes (Like) button
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.rotate(
                  angle: 2.0 * (math.pi / 180),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _nextProfile(liked: true),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: 66,
                        height: 66,
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          border: Border.all(color: AppColors.nearBlack, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              offset: const Offset(2, 3),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.favorite_rounded,
                          size: 32,
                          color: AppColors.nearBlack,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'could work?',
                  style: GoogleFonts.caveat(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF625C52),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Swipe note
        Center(
          child: Transform.rotate(
            angle: -2.0 * (math.pi / 180),
            child: Text(
              'swipe through → don\'t overthink it',
              style: GoogleFonts.caveat(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF625C52),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Context Paper (For Your Friend)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: const Color(0xFFE2D9C7), // var(--paper2)
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FOR YOUR FRIEND',
                style: GoogleFonts.barlowCondensed(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: AppColors.nearBlack,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _selectedFriend.forYourFriendContext,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.35,
                  color: const Color(0xFF45413A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // SCREEN 4: DONE (NICE EYE / SCOUTING COMPLETE)
  // ==========================================
  Widget _buildDoneScreen() {
    return Column(
      key: const ValueKey('wingman_done'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                _candidateIndex = 0;
                _currentScreen = WingmanSubScreen.swipe;
              });
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            icon: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.nearBlack),
            label: Text(
              'back to profiles',
              style: GoogleFonts.caveat(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.nearBlack,
              ),
            ),
          ),
        ),
        const SizedBox(height: 36),

        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '✦',
                style: TextStyle(
                  fontSize: 54,
                  color: AppColors.nearBlack.withValues(alpha: 0.85),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nice eye.',
                style: GoogleFonts.kalam(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: AppColors.nearBlack,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Text(
                  'You found someone worth putting in front of your friend. Keep scouting or send the setup when it feels right.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.45,
                    color: const Color(0xFF625C52),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _candidateIndex = 0;
                    _currentScreen = WingmanSubScreen.swipe;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.nearBlack,
                  foregroundColor: AppColors.cream,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                ),
                child: Text(
                  'keep scouting →',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cream,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'one good match is enough.',
                style: GoogleFonts.caveat(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF625C52),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) => false;
}
