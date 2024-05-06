import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../config/size_config.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  double customWidth(BuildContext context) => SizeConfig.displayWidth(context) * 0.5;
  
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.withOpacity(0.6),
      child: Center(
        child: Container(
          height: 136,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: SizeConfig.displayWidth(context) * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ShimmerPlaceholder(height: 90, width: 90),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerPlaceholder(width: customWidth(context), height: 25),
                  ShimmerPlaceholder(width: customWidth(context)),
                  ShimmerPlaceholder(width: customWidth(context)),
                  ShimmerPlaceholder(width: customWidth(context)),
                ]
              )
            ]
          ),
        ),
      ),
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({super.key, this.height, this.width, this.radius});

  final double? height, width, radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 8.0))
      )
    );
  }
}