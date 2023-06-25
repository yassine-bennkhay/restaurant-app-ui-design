import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PriceShimmer extends StatelessWidget {
  const PriceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 120,
                  height: 16,
                  color: Colors.white,
                ),
                Container(
                  width: 80,
                  height: 16,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 16,
                  color: Colors.white,
                ),
                Container(
                  width: 80,
                  height: 16,
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 4,
            )
          ],
        ),
      ),
    );
  }
}
