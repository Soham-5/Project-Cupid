import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/widgets/friend_stack.dart';

/// Empty placeholder view for the "vibes" tab in the Wingman workspace
class WorkspaceVibesView extends StatelessWidget {
  final VoidCallback? onBack;

  const WorkspaceVibesView({
    super.key,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar with title & friend stack
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onBack,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "vibes",
                        style: GoogleFonts.kalam(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: AppColors.nearBlack,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "moments & mutual energy",
                        style: AppTextStyles.handwritten(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF625C52),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onBack,
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

          const SizedBox(height: 80),

          // Placeholder Notice
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.lime.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    size: 32,
                    color: AppColors.nearBlack,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "vibes coming soon",
                  style: GoogleFonts.caveat(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.nearBlack,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "sharing candid moments for your people",
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF625C52),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
