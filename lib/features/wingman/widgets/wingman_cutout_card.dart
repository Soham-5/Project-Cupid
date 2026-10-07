import 'package:flutter/material.dart';

/// Reusable paper cutout container with organic edges, matching the prototype:
/// clip-path: polygon(0 2%,12% 0,25% 1.2%,39% .1%,54% 1.3%,68% .3%,82% 1%,100% 0,99% 22%,100% 45%,99% 67%,100% 98%,88% 99%,76% 98%,63% 100%,49% 98.6%,36% 100%,22% 98.5%,8% 100%,0 98%,1% 75%,0 51%,1% 28%)
class WingmanCutoutCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;

  const WingmanCutoutCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(19, 20, 19, 18),
    this.backgroundColor = const Color(0xFFF8F2E7), // var(--paper)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 17,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipPath(
        clipper: const _CutoutPaperClipper(),
        child: Container(
          color: backgroundColor,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class _CutoutPaperClipper extends CustomClipper<Path> {
  const _CutoutPaperClipper();

  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    // Organic polygon percentages translated from prototype
    final points = <Offset>[
      Offset(0.00 * w, 0.02 * h),
      Offset(0.12 * w, 0.00 * h),
      Offset(0.25 * w, 0.012 * h),
      Offset(0.39 * w, 0.001 * h),
      Offset(0.54 * w, 0.013 * h),
      Offset(0.68 * w, 0.003 * h),
      Offset(0.82 * w, 0.010 * h),
      Offset(1.00 * w, 0.000 * h),
      Offset(0.99 * w, 0.220 * h),
      Offset(1.00 * w, 0.450 * h),
      Offset(0.99 * w, 0.670 * h),
      Offset(1.00 * w, 0.980 * h),
      Offset(0.88 * w, 0.990 * h),
      Offset(0.76 * w, 0.980 * h),
      Offset(0.63 * w, 1.000 * h),
      Offset(0.49 * w, 0.986 * h),
      Offset(0.36 * w, 1.000 * h),
      Offset(0.22 * w, 0.985 * h),
      Offset(0.08 * w, 1.000 * h),
      Offset(0.00 * w, 0.980 * h),
      Offset(0.01 * w, 0.750 * h),
      Offset(0.00 * w, 0.510 * h),
      Offset(0.01 * w, 0.280 * h),
    ];

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _CutoutPaperClipper oldClipper) => false;
}
