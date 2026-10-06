import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

import '../utils/wingman_action_handler.dart';

/// Interactive dislike and like action buttons with organic press micro-animations.
/// Dislike: Off-white circular button with 'X' and handwritten "dislike" label
/// Like: Vibrant pink circular button with black heart and handwritten "like" label
class WorkspaceActionButtons extends StatelessWidget {
  final VoidCallback? onDislike;
  final VoidCallback? onLike;

  const WorkspaceActionButtons({
    super.key,
    this.onDislike,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Dislike (X) with unique ID wm-home-dislike-btn
        WingmanInteractive(
          id: 'wm-home-dislike-btn',
          customOnTap: onDislike,
          child: _WorkspaceRoundButton(
            label: 'dislike',
            backgroundColor: const Color(0xFFF8F2E7),
            borderColor: AppColors.nearBlack.withValues(alpha: 0.12),
            shadowColor: Colors.black.withValues(alpha: 0.08),
            iconWidget: const _DislikeXIcon(),
          ),
        ),
        const SizedBox(width: 44),
        // Like (Heart) with unique ID wm-home-like-btn
        WingmanInteractive(
          id: 'wm-home-like-btn',
          customOnTap: onLike,
          child: _WorkspaceRoundButton(
            label: 'like',
            backgroundColor: const Color(0xFFF47B95),
            shadowColor: const Color(0xFFF47B95).withValues(alpha: 0.35),
            iconWidget: const Icon(
              Icons.favorite_rounded,
              color: AppColors.nearBlack,
              size: 29,
            ),
          ),
        ),
      ],
    );
  }
}

class _WorkspaceRoundButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color? borderColor;
  final Color shadowColor;
  final Widget iconWidget;

  const _WorkspaceRoundButton({
    required this.label,
    required this.backgroundColor,
    this.borderColor,
    required this.shadowColor,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 66,
          height: 66,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: iconWidget,
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: GoogleFonts.caveat(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            color: AppColors.nearBlack,
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the Dislike button showing the bold '✕'
/// with the authentic handwritten accent stroke at the top right.
class _DislikeXIcon extends StatelessWidget {
  const _DislikeXIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The main X
          Text(
            '✕',
            style: GoogleFonts.ibmPlexSans(
              fontSize: 27,
              fontWeight: FontWeight.w700,
              color: AppColors.nearBlack,
              height: 1.0,
            ),
          ),
          // Subtle handwritten accent tick at top-right
          Positioned(
            top: 2,
            right: 2,
            child: Transform.rotate(
              angle: 0.35,
              child: Container(
                width: 2.2,
                height: 7,
                decoration: BoxDecoration(
                  color: AppColors.nearBlack,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
