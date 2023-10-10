import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class PortfolioShimmerWidget extends StatelessWidget {
  const PortfolioShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Shimmer.fromColors(
              period: const Duration(milliseconds: 800),
              baseColor: CupertinoColors.systemGrey5,
              highlightColor: CupertinoColors.systemGrey6,
              child: Container(
                width: MediaQuery.of(context).size.width - 70,
                height: 20,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: CupertinoColors.systemGrey5,
                ),
              )),
        ),
        Shimmer.fromColors(
            period: const Duration(milliseconds: 800),
            baseColor: CupertinoColors.systemGrey5,
            highlightColor: CupertinoColors.systemGrey6,
            child: Container(
              width: MediaQuery.of(context).size.width - 70,
              height: 130,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: CupertinoColors.systemGrey5,
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Shimmer.fromColors(
              period: const Duration(milliseconds: 800),
              baseColor: CupertinoColors.systemGrey5,
              highlightColor: CupertinoColors.systemGrey6,
              child: Container(
                width: MediaQuery.of(context).size.width - 70,
                height: 25,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: CupertinoColors.systemGrey5,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Shimmer.fromColors(
              period: const Duration(milliseconds: 800),
              baseColor: CupertinoColors.systemGrey5,
              highlightColor: CupertinoColors.systemGrey6,
              child: Container(
                width: MediaQuery.of(context).size.width - 70,
                height: 25,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: CupertinoColors.systemGrey5,
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Shimmer.fromColors(
              period: const Duration(milliseconds: 800),
              baseColor: CupertinoColors.systemGrey5,
              highlightColor: CupertinoColors.systemGrey6,
              child: Container(
                width: MediaQuery.of(context).size.width - 70,
                height: 25,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: CupertinoColors.systemGrey5,
                ),
              )),
        )
      ],
    );
  }
}

class BoxShimmer extends StatelessWidget {
  double width;
  double height;
  BoxShimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 800),
        baseColor: CupertinoColors.systemGrey5,
        highlightColor: CupertinoColors.systemGrey6,
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: CupertinoColors.systemGrey5,
          ),
        ));
  }
}
