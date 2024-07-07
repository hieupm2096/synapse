import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:synapse/core/extension/build_context_ext.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
  });

  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.shadColor.secondary,
      highlightColor: context.shadColor.background,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.shadColor.background,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
