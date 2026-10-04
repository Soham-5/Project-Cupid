import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/micro_doodles.dart';
import '../../shared/widgets/sticky_note.dart';
import '../../data/repositories/mock_dating_repository.dart';
import '../../data/models/plan_model.dart';
import 'widgets/plan_card_widget.dart';

class PlansScreen extends ConsumerStatefulWidget {
  const PlansScreen({super.key});

  @override
  ConsumerState<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends ConsumerState<PlansScreen> {
  void _triggerSurpriseMe(List<Plan> plans) {
    if (plans.isEmpty) return;
    final randomPlan = plans[math.Random().nextInt(plans.length)];

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lime, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.lime.withValues(alpha: 0.25),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Text(
                "SURPRISE PLAN PICKED! 🎲",
                textAlign: TextAlign.center,
                style: AppTextStyles.markerHeading(
                  fontSize: 22,
                  color: AppColors.lime,
                ),
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Image.asset(randomPlan.photoPath, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                randomPlan.title.replaceAll('\n', ' '),
                textAlign: TextAlign.center,
                style: AppTextStyles.markerHeading(
                  fontSize: 20,
                  color: AppColors.cream,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lime,
                  foregroundColor: AppColors.nearBlack,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "Count me in!",
                  style: AppTextStyles.handwritten(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.nearBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(plansListProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final contentWidth = screenWidth > 480 ? 440.0 : screenWidth;

    return Scaffold(
      backgroundColor: AppColors.nearBlack,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: SizedBox(
            width: contentWidth,
            child: Stack(
              children: [
                // Scrollable content
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Header: "plan something cool?" + Pink "+" Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "plan something",
                                style: AppTextStyles.handwritten(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.cream,
                                ).copyWith(height: 1.0),
                              ),
                              const SizedBox(height: 2),
                              ScribbleOvalWrapper(
                                color: AppColors.lime,
                                strokeWidth: 2.2,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                child: Text(
                                  "cool?",
                                  style: AppTextStyles.handwritten(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.cream,
                                  ).copyWith(height: 1.0),
                                ),
                              ),
                            ],
                          ),
                          // Pink circular "+" button
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.pink,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.pink.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.nearBlack,
                              size: 24,
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1, end: 0),

                      const SizedBox(height: 20),

                      // Vertical list of plan cards
                      for (int i = 0; i < plans.length; i++) ...[
                        PlanCardWidget(
                          plan: plans[i],
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.cardDark,
                                content: Text(
                                  "Joined ${plans[i].title.replaceAll('\n', ' ')}!",
                                  style: AppTextStyles.handwritten(
                                    color: AppColors.lime,
                                    fontSize: 18,
                                  ),
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        )
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: 100 * (i + 1)))
                            .slideY(begin: 0.08, end: 0),
                        const SizedBox(height: 18),
                      ],

                      // Bottom spacing for sticky note and bottom navigation
                      const SizedBox(height: 110),
                    ],
                  ),
                ),

                // Floating lime sticky note: "or! surprise me" (bottom right)
                Positioned(
                  bottom: 16,
                  right: 14,
                  child: StickyNote.surpriseMe(
                    rotation: -0.07,
                    onTap: () => _triggerSurpriseMe(plans),
                  ).animate().fadeIn(delay: 500.ms).scale(begin: const Offset(0.7, 0.7)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
