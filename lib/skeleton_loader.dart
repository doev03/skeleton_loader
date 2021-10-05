library skeleton_loader;

import 'package:flutter/material.dart';
import 'package:skeleton_loader/skeleton_loader_view.dart';

///Skeleton Loader
class SkeletonLoader extends StatelessWidget {
  final Color backgroundColor;
  final Color indicatorColor;
  final double indicatorWidth;
  final double indicatorBlurSigma;
  final BorderRadius borderRadius;
  final Duration duration;
  final double? width;
  final double? height;

  const SkeletonLoader({
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = this.height ?? constraints.maxHeight;
        final width = this.width ?? constraints.maxWidth;

        return SkeletonLoaderView(
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
          indicatorWidth: indicatorWidth,
          indicatorBlurSigma: indicatorBlurSigma,
          borderRadius: borderRadius,
          duration: duration,
          width: width,
          height: height,
        );
      },
    );
  }
}
