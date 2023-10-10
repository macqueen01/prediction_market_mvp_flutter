import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perdiction_market_mvp/Chart.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/Entities/SnapshotEntity.dart';
import 'package:perdiction_market_mvp/MarketDetail_PersonalInventory.dart';
import 'package:perdiction_market_mvp/others/navigationBars.dart';
import 'package:perdiction_market_mvp/others/tabBar.dart';
import 'package:perdiction_market_mvp/predictionMarketMenu.dart';
import 'package:readmore/readmore.dart';

class PredictionMarketPageArguments {
  final PredictionMarketMenuEntity marketMenuEntity;

  PredictionMarketPageArguments({required this.marketMenuEntity});
}

class PredictionMarketPage extends StatelessWidget {
  PredictionMarketMenuEntity? marketMenuEntity;

  PredictionMarketPage({
    super.key,
    this.marketMenuEntity,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemBackground,
        navigationBar: CupertinoNavigationBar(
          border: Border.all(color: CupertinoColors.systemBackground),
          backgroundColor: CupertinoColors.systemBackground,
          middle: const Text('예측시장'),
          leading: Container(
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                CupertinoIcons.back,
                size: 30,
                color: CupertinoColors.darkBackgroundGray,
              ),
            ),
          ),
        ),
        child: Scaffold(
          bottomNavigationBar:
              MarketDetailBottomNavigationBar(marketEntity: marketMenuEntity!),
          backgroundColor: CupertinoColors.systemBackground,
          body: DejaTabBarView(
              tabBarProperties: const TabBarProperties(
                  indicatorColor: CupertinoColors.darkBackgroundGray),
              tabs: const [
                Text(
                  "차트",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'NotoSansCJKr',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 63, 63, 63),
                  ),
                ),
                Text(
                  "내가 산 예측",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'NotoSansCJKr',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 63, 63, 63),
                  ),
                ),
              ],
              views: [
                SingleChildScrollView(
                    child: ChartView(marketMenu: marketMenuEntity!)),
                PersonalInventory(
                  marketMenu: marketMenuEntity!,
                )
              ]),
        ));
  }
}

class ChartView extends StatelessWidget {
  PredictionMarketMenuEntity marketMenu;

  ChartView({
    super.key,
    required this.marketMenu,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MarketImageHolder(image: marketMenu.image, is_new: false),
                    Container(
                      width: 220,
                      height: 80,
                      alignment: Alignment.centerLeft,
                      child:
                          IsResolvedLabel(is_resolved: marketMenu.is_resolved),
                    )
                  ],
                ),
              )),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35.0),
              child: Text(
                marketMenu.title,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20,
            child: Padding(
              padding: const EdgeInsets.only(left: 35.0, right: 35, top: 5),
              child: Text(
                '예측 시작일: ${marketMenu.startTime.toString().split(' ')[0]}',
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 72, 72, 72),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width - 70,
              decoration: ShapeDecoration(
                color: CupertinoColors.systemGrey6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 12, right: 12, bottom: 11),
                child: ReadMoreText(
                  marketMenu.description,
                  textAlign: TextAlign.left,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  colorClickableText: CupertinoColors.activeBlue,
                  trimCollapsedText: '더보기',
                  trimExpandedText: '접기',
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'NotoSansCJKr',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 130, 130, 130),
                  ),
                ),
              ),
            ),
          ),
          Container(
              width: 330,
              height: 80,
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 5, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "그럴 것이다",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'NotoSansCJKr',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 63, 63, 63),
                          ),
                        ),
                        Text(
                          "아닐 것이다",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'NotoSansCJKr',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 63, 63, 63),
                          ),
                        )
                      ],
                    ),
                  ),
                  PercentBar(
                      height: 40,
                      width: 300,
                      positiveProbability:
                          marketMenu.poolState!.positiveProbability,
                      negativeProbability:
                          marketMenu.poolState!.negativeProbability,
                      cornerRadius: 10)
                ],
              )),
          ChartTabViewWidget()
        ],
      ),
    );
  }
}

class ChartTabViewWidget extends StatefulWidget {
  ChartTabViewWidget({super.key});

  @override
  State<ChartTabViewWidget> createState() => _ChartTabViewState();
}

class _ChartTabViewState extends State<ChartTabViewWidget> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 35),
        child: CustomSlidingSegmentedControl(
          initialValue: 0,
          padding: 20,
          children: const {
            0: Text(
              "전체",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'NotoSansCJKr',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 74, 74, 74),
              ),
            ),
            1: Text(
              "세달",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'NotoSansCJKr',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 74, 74, 74),
              ),
            ),
            2: Text(
              "한달",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'NotoSansCJKr',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 74, 74, 74),
              ),
            ),
            3: Text(
              "일주일",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'NotoSansCJKr',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 74, 74, 74),
              ),
            ),
            4: Text(
              "하루",
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: 'NotoSansCJKr',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 74, 74, 74),
              ),
            ),
          },
          height: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 242, 242, 242),
            borderRadius: BorderRadius.circular(8),
          ),
          thumbDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: const Offset(
                  0.0,
                  2.0,
                ),
              ),
            ],
          ),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          onValueChanged: (v) {
            setState(() {
              currentTab = v;
            });
          },
        ),
      ),

      // ---- Chart ----

      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: (currentTab == 0)
            ? AspectRatio(
                aspectRatio: 3 / 2,
                child: DateChartView(
                  snapshots: getSnapshotsTest(),
                ))
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Center(
                  child: Text(
                    '아직 준비중입니다.',
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansCJKr',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 74, 74, 74),
                    ),
                  ),
                ),
              ),
      )
    ]);
  }
}

class IsResolvedLabel extends StatelessWidget {
  final bool is_resolved;
  const IsResolvedLabel({super.key, required this.is_resolved});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 25,
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: (is_resolved)
            ? const Color.fromARGB(255, 142, 142, 142)
            : const Color(0xFF84F241),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: (is_resolved)
          ? const Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Text(
                '종료됨',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 74, 74, 74),
                ),
              ),
            )
          : const Padding(
              padding: EdgeInsets.only(bottom: 1.0),
              child: Text(
                '진행중',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
    );
  }
}
