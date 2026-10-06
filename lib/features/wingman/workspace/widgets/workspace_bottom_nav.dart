import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/torn_paper.dart';

/// The isolated bottom navigation bar for the Wingman workspace screens.
/// Features:
/// - Torn-paper top edge
/// - 5 tabs: [home], [blind date], [match], [vibes], [profile]
/// - Active tab gets the lime-green rounded highlight
/// - Switches between tabs with [onTabSelected]
class WorkspaceBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;

  const WorkspaceBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipPath(
        clipper: const TornPaperClipper(
          edges: TornEdges(top: true),
          seed: 99,
          tearDepth: 4.0,
        ),
        child: Container(
          color: AppColors.cream,
          padding: EdgeInsets.fromLTRB(
            12,
            10,
            12,
            bottomInset > 0 ? bottomInset + 4 : 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _WorkspaceNavItem(
                index: 0,
                label: 'home',
                icon: Icons.home_rounded,
                isActive: currentIndex == 0,
                onTap: () => onTabSelected?.call(0),
              ),
              _WorkspaceNavItem(
                index: 1,
                label: 'blind date',
                icon: Icons.calendar_today_outlined,
                isActive: currentIndex == 1,
                onTap: () => onTabSelected?.call(1),
              ),
              _WorkspaceNavItem(
                index: 2,
                label: 'match',
                icon: Icons.favorite_border_rounded,
                isActive: currentIndex == 2,
                onTap: () => onTabSelected?.call(2),
              ),
              _WorkspaceNavItem(
                index: 3,
                label: 'vibes',
                icon: Icons.sentiment_satisfied_alt_outlined,
                isActive: currentIndex == 3,
                onTap: () => onTabSelected?.call(3),
              ),
              _WorkspaceNavItem(
                index: 4,
                label: 'profile',
                icon: Icons.person_outline_rounded,
                isActive: currentIndex == 4,
                onTap: () => onTabSelected?.call(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkspaceNavItem extends StatelessWidget {
  final int index;
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _WorkspaceNavItem({
    required this.index,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isActive)
            Container(
              width: 44,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.lime,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: AppColors.nearBlack,
                size: 22,
              ),
            )
          else
            SizedBox(
              width: 44,
              height: 30,
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.nearBlack,
                  size: 21,
                ),
              ),
            ),
          const SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.ibmPlexSans(
              fontSize: 10,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.nearBlack,
            ),
          ),
        ],
      ),
    );
  }
}
