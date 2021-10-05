import 'package:flutter/material.dart';

class SkeletonLoaderView extends StatefulWidget {
  final Color backgroundColor;
  final Color indicatorColor;
  final double indicatorWidth;
  final double indicatorBlurSigma;
  final BorderRadius borderRadius;
  final Duration duration;
  final double? width;
  final double? height;

  const SkeletonLoaderView({
    Key? key,
    this.backgroundColor = const Color(0xFFEAEAEA),
    this.indicatorColor = Colors.white,
    this.indicatorWidth = 30.0,
    this.indicatorBlurSigma = 15.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.duration = const Duration(seconds: 1),
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _SkeletonLoaderViewState createState() => _SkeletonLoaderViewState();
}

class _SkeletonLoaderViewState extends State<SkeletonLoaderView> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      lowerBound: 0.0,
      upperBound: 1.0 + (widget.indicatorWidth + 2 * widget.indicatorBlurSigma) / widget.width!,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
        child: ClipRect(
          child: AnimatedBuilder(
            animation: controller,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomPaint(
                size: Size(widget.indicatorWidth, widget.height!),
                painter: BlurBoxPainter(widget.indicatorColor, widget.indicatorBlurSigma),
              ),
            ),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(controller.value * widget.width! - widget.indicatorWidth - 2 * widget.indicatorBlurSigma, 0),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}

class BlurBoxPainter extends CustomPainter {
  final Color color;
  final double indicatorBlurSigma;

  BlurBoxPainter(this.color, this.indicatorBlurSigma);

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, indicatorBlurSigma);
    canvas.drawRect(Rect.fromPoints(Offset(0, -size.height), Offset(size.width, 2 * size.height)), line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

