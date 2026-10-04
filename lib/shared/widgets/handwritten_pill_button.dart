import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'micro_doodles.dart';

/// Black pill button with cream handwritten text and a vibrant pink doodle underline stroke
class HandwrittenPillButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final bool showPinkUnderline;
  final Color backgroundColor;
  final Color textColor;
  final Color underlineColor;
  final double fontSize;

  const HandwrittenPillButton({
    super.key,
    required this.text,
    this.onPressed,
    this.width = 180,
    this.height = 48,
    this.showPinkUnderline = true,
    this.backgroundColor = AppColors.nearBlack,
    this.textColor = AppColors.cream,
    this.underlineColor = AppColors.scribblePink,
    this.fontSize = 20,
  });

  @override
  State<HandwrittenPillButton> createState() => _HandwrittenPillButtonState();
}

class _HandwrittenPillButtonState extends State<HandwrittenPillButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.height / 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                widget.text,
                style: AppTextStyles.markerHeading(
                  fontSize: widget.fontSize,
                  color: widget.textColor,
                  letterSpacing: 0.5,
                ).copyWith(height: 1.0),
              ),
            ),
            if (widget.showPinkUnderline) ...[
              const SizedBox(height: 2),
              SizedBox(
                width: widget.width * 0.72,
                height: 8,
                child: CustomPaint(
                  painter: ScribbleUnderlinePainter(
                    color: widget.underlineColor,
                    strokeWidth: 3.2,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
