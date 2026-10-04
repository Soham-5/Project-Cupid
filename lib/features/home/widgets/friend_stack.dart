import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Overlapping friend avatar stack with count badge (friends who curated the profile)
class FriendStack extends StatelessWidget {
  final List<String> avatars;
  final int count;

  const FriendStack({
    super.key,
    required this.avatars,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 58,
            height: 32,
            child: Stack(
              children: [
                if (avatars.isNotEmpty)
                  Positioned(
                    left: 0,
                    child: _AvatarCircle(imagePath: avatars[0]),
                  ),
                if (avatars.length > 1)
                  Positioned(
                    left: 18,
                    child: _AvatarCircle(imagePath: avatars[1]),
                  ),
                Positioned(
                  left: 36,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.nearBlack,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cream, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$count',
                      style: AppTextStyles.bodySans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cream,
                      ),
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
}

class _AvatarCircle extends StatelessWidget {
  final String imagePath;

  const _AvatarCircle({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.cream, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
