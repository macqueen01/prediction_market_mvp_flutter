import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';

class PredictionMarketTile extends StatefulWidget {
  PredictionMarketMenuEntity marketMenu;
  PoolStateEntity poolState;

  PredictionMarketTile({
    super.key,
    required this.marketMenu,
    required this.poolState,
  });

  @override
  State<PredictionMarketTile> createState() => _PredictionMarketTileState();
}

class _PredictionMarketTileState extends State<PredictionMarketTile>
    with TickerProviderStateMixin {
  Duration _duration = const Duration(milliseconds: 500);
  late AnimationController _animationController =
      AnimationController(vsync: this, duration: _duration);

  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    opacityAnimation.addListener(() {
      setState(() {});
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.opacityAnimation.value,
      child: Container(
        width: 350,
        height: 240,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: CupertinoColors.systemGrey6,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: PredictionMarketMenuItemHeader(
                  marketMenu: widget.marketMenu,
                  poolState: widget.marketMenu.poolState!),
            ),
            Container(
                width: 330,
                height: 65,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "그럴 것이다",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'NotoSansCJKr',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 63, 63, 63),
                            ),
                          ),
                          Text(
                            "아닐 것이다",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'NotoSansCJKr',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 63, 63, 63),
                            ),
                          )
                        ],
                      ),
                    ),
                    PercentBar(
                        height: 30,
                        width: 300,
                        positiveProbability:
                            widget.marketMenu.poolState!.positiveProbability,
                        negativeProbability:
                            widget.marketMenu.poolState!.negativeProbability,
                        cornerRadius: 10)
                  ],
                )),
            Container(
              width: 280,
              height: 40,
              alignment: Alignment.bottomCenter,
              child: const Icon(
                CupertinoIcons.chevron_compact_down,
                size: 40,
                color: CupertinoColors.systemGrey3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PercentBar extends StatelessWidget {
  double height;
  double width;
  double positiveProbability;
  double negativeProbability;
  double cornerRadius;

  PercentBar({
    super.key,
    required this.height,
    required this.width,
    required this.positiveProbability,
    required this.negativeProbability,
    required this.cornerRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: height,
            width: width * positiveProbability - 1,
            color: const Color.fromARGB(255, 28, 99, 221),
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 1),
              child: Text(
                '${positiveProbability.toStringAsFixed(2)} %',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            ),
          ),
          Container(
            height: height,
            width: 2,
            color: CupertinoColors.systemGrey6,
          ),
          Container(
            height: height,
            width: width * negativeProbability - 1,
            color: const Color(0xFFE02020),
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 1),
              child: Text(
                '${negativeProbability.toStringAsFixed(2)} %',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PredictionMarketMenuItemHeader extends StatelessWidget {
  PredictionMarketMenuEntity marketMenu;
  PoolStateEntity poolState;

  PredictionMarketMenuItemHeader({
    super.key,
    required this.marketMenu,
    required this.poolState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 120,
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              width: 325,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MarketImageHolder(image: marketMenu.image, is_new: false),
                  Container(
                    width: 220,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      marketMenu.title,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'NotoSansCJKr',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Container(
              width: 325,
              height: 45,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      child: PercentChangeIndicator1(
                        changeRate: poolState.recentPositiveProbabilityChange,
                        has_increased: (poolState
                            .recentPositiveProbabilityChange
                            .isGreaterThan(0)),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 15,
                        child: Text(
                          '예측 시작일: ${marketMenu.startTime.toString().split(' ')[0]}',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'NotoSansCJKr',
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 72, 72, 72),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 220,
                        height: 15,
                        child: Text(
                          '예측 마감일: ${marketMenu.endTime.toString().split(' ')[0]}',
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'NotoSansCJKr',
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 72, 72, 72),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PercentChangeIndicator1 extends StatelessWidget {
  double changeRate;
  bool has_increased;

  PercentChangeIndicator1({
    super.key,
    required this.changeRate,
    required this.has_increased,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 25,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: (has_increased)
            ? const Color.fromARGB(255, 125, 207, 74)
            : const Color(0xFFE02020),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: (has_increased)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Text(
                '+${changeRate.toStringAsFixed(2)}%',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Text(
                '${changeRate.toStringAsFixed(2)}%',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            ),
    );
  }
}

class PercentChangeIndicator2 extends StatelessWidget {
  double changeRate;
  bool has_increased;

  PercentChangeIndicator2({
    super.key,
    required this.changeRate,
    required this.has_increased,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 32,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color:
            (has_increased) ? const Color(0xFF84F241) : const Color(0xFFE02020),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: (has_increased)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Text(
                '+${changeRate.toStringAsFixed(2)}%',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 1.0),
              child: Text(
                '${changeRate.toStringAsFixed(2)}%',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            ),
    );
  }
}

class MarketImageHolder extends StatelessWidget {
  String image;
  bool is_new;

  MarketImageHolder({super.key, required this.image, required this.is_new});

  Widget isNewLabel() {
    if (is_new) {
      return Container(
        width: 80,
        height: 30,
        alignment: Alignment.center,
        child: Container(
            width: 60,
            height: 20,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(255, 140, 106, 203),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(bottom: 1.5),
              child: Text(
                '신규 예측',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 254, 254, 254),
                ),
              ),
            )),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            width: 80,
            child: Container(
              width: 60,
              height: 60,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(73),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Positioned(bottom: -5, child: isNewLabel()),
        ],
      ),
    );
  }
}
