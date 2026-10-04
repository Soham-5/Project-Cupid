import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'torn_paper.dart';

enum NavTab { home, plans, match, vibes, you }

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
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
          padding: EdgeInsets.fromLTRB(16, 12, 16, bottomInset > 0 ? bottomInset + 4 : 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                index: 0,
                isSelected: currentIndex == 0,
                label: 'home',
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                onTap: () => onTabSelected(0),
              ),
              _NavItem(
                index: 1,
                isSelected: currentIndex == 1,
                label: 'plans',
                icon: Icons.calendar_today_outlined,
                activeIcon: Icons.calendar_today_rounded,
                onTap: () => onTabSelected(1),
              ),
              _NavItem(
                index: 2,
                isSelected: currentIndex == 2,
                label: 'match',
                icon: Icons.favorite_border_rounded,
                activeIcon: Icons.favorite_rounded,
                onTap: () => onTabSelected(2),
              ),
              _NavItem(
                index: 3,
                isSelected: currentIndex == 3,
                label: 'vibes',
                icon: Icons.sentiment_satisfied_alt_outlined,
                activeIcon: Icons.sentiment_very_satisfied_rounded,
                onTap: () => onTabSelected(3),
              ),
              _NavItem(
                index: 4,
                isSelected: currentIndex == 4,
                label: 'you',
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                onTap: () => onTabSelected(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final int index;
  final bool isSelected;
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.22).chain(CurveTween(curve: Curves.easeOutCubic)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.22, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)), weight: 50),
    ]).animate(_bounceController);
  }

  @override
  void didUpdateWidget(covariant _NavItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _bounceController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onTap();
        _bounceController.forward(from: 0.0);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              width: 38,
              height: 32,
              decoration: BoxDecoration(
                color: widget.isSelected ? AppColors.lime : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(
                widget.isSelected ? widget.activeIcon : widget.icon,
                size: 21,
                color: AppColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            widget.label,
            style: AppTextStyles.bodySans(
              fontSize: 11,
              fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.nearBlack,
            ),
          ),
        ],
      ),
    );
  }
}
