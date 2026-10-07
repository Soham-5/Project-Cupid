import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../features/wingman/wingman_config.dart';
import '../../features/wingman/widgets/wingman_doodle.dart';
import 'torn_paper.dart';

enum NavTab { home, plans, match, vibes, wingman, you }

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
    final isWingmanEnabled = WingmanConfig.enabled;

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
            isWingmanEnabled ? 8 : 16,
            10,
            isWingmanEnabled ? 8 : 16,
            bottomInset > 0 ? bottomInset + 4 : 10,
          ),
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
              if (isWingmanEnabled)
                _NavItem(
                  index: 4,
                  isSelected: currentIndex == 4,
                  label: 'wingman',
                  icon: Icons.diversity_1_outlined,
                  activeIcon: Icons.diversity_1_rounded,
                  customIcon: const WingmanDoodle(size: 20, color: AppColors.nearBlack),
                  customActiveIcon: const WingmanDoodle(size: 20, color: AppColors.nearBlack),
                  onTap: () => onTabSelected(4),
                ),
              _NavItem(
                index: isWingmanEnabled ? 5 : 4,
                isSelected: currentIndex == (isWingmanEnabled ? 5 : 4),
                label: 'you',
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person_rounded,
                onTap: () => onTabSelected(isWingmanEnabled ? 5 : 4),
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
  final Widget? customIcon;
  final Widget? customActiveIcon;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.isSelected,
    required this.label,
    required this.icon,
    required this.activeIcon,
    this.customIcon,
    this.customActiveIcon,
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
    final Widget iconWidget;
    if (widget.isSelected && widget.customActiveIcon != null) {
      iconWidget = widget.customActiveIcon!;
    } else if (widget.customIcon != null) {
      iconWidget = widget.customIcon!;
    } else {
      iconWidget = Icon(
        widget.isSelected ? widget.activeIcon : widget.icon,
        size: 20,
        color: AppColors.nearBlack,
      );
    }

    return Expanded(
      child: GestureDetector(
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
                width: 36,
                height: 30,
                decoration: BoxDecoration(
                  color: widget.isSelected ? AppColors.lime : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: iconWidget,
              ),
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.label,
                maxLines: 1,
                style: AppTextStyles.bodySans(
                  fontSize: 10.5,
                  fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: AppColors.nearBlack,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
