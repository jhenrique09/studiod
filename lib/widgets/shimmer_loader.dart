import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  Widget shimmerContent;

  ShimmerLoader(this.shimmerContent);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        enabled: true,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return shimmerContent;
          },
        ),
      ))
    ]);
  }
}
