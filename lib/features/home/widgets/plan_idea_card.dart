import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/torn_paper.dart';
import '../../../shared/widgets/micro_doodles.dart';

class PlanIdeaCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onMaybeTap;
  final VoidCallback? onLetsGoTap;

  const PlanIdeaCard({
    super.key,
    required this.title,
    this.subtitle = "Plan idea",
    this.onMaybeTap,
    this.onLetsGoTap,
  });

  @override
  State<PlanIdeaCard> createState() => _PlanIdeaCardState();
}

class _PlanIdeaCardState extends State<PlanIdeaCard> {
  bool _maybePressed = false;
  bool _letsGoPressed = false;

  @override
  Widget build(BuildContext context) {
    return TornPaper(
      color: AppColors.lavender,
      edges: TornEdges.all,
      seed: 88,
      tearDepth: 4.5,
      elevation: 7,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Subtitle "Plan idea"
          Text(
            widget.subtitle,
            style: AppTextStyles.handwritten(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.nearBlack.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 2),

          // Title + Spider doodle
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyles.markerHeading(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: AppColors.nearBlack,
                    letterSpacing: 0.5,
                  ).copyWith(height: 1.05),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4, right: 8),
                child: SpiderDoodle(size: 28),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Action buttons row: "maybe ↓" and "let's go!"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // "maybe ↓" button (Cream torn pill)
              GestureDetector(
                onTapDown: (_) => setState(() => _maybePressed = true),
                onTapUp: (_) {
                  setState(() => _maybePressed = false);
                  widget.onMaybeTap?.call();
                },
                onTapCancel: () => setState(() => _maybePressed = false),
                child: AnimatedScale(
                  scale: _maybePressed ? 0.94 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: TornPaper(
                    color: AppColors.creamLight,
                    edges: TornEdges.horizontal,
                    elevation: 3,
                    tearDepth: 2.0,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'maybe',
                          style: AppTextStyles.handwritten(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.nearBlack,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_downward_rounded,
                          size: 16,
                          color: AppColors.nearBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // "let's go!" button (Black pill wrapped with lime hand-drawn scribble oval)
              GestureDetector(
                onTapDown: (_) => setState(() => _letsGoPressed = true),
                onTapUp: (_) {
                  setState(() => _letsGoPressed = false);
                  widget.onLetsGoTap?.call();
                },
                onTapCancel: () => setState(() => _letsGoPressed = false),
                child: AnimatedScale(
                  scale: _letsGoPressed ? 0.94 : 1.0,
                  duration: const Duration(milliseconds: 100),
                  child: ScribbleOvalWrapper(
                    color: AppColors.lime,
                    strokeWidth: 2.4,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.nearBlack,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "let's go!",
                        style: AppTextStyles.handwritten(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.cream,
                        ).copyWith(height: 1.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
