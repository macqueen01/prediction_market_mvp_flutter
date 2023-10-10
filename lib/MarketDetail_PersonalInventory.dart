import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perdiction_market_mvp/Entities/Portfolios.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/OrderPages/OrderPage.dart';
import 'package:perdiction_market_mvp/OrderPages/SellOrderPage.dart';
import 'package:perdiction_market_mvp/predictionMarketMenu.dart';
import 'package:perdiction_market_mvp/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalInventory extends StatefulWidget {
  PredictionMarketMenuEntity marketMenu;
  PersonalInventory({super.key, required this.marketMenu});

  @override
  State<PersonalInventory> createState() => _PersonalInventoryState();
}

class _PersonalInventoryState extends State<PersonalInventory> {
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  bool is_refreshing = true;
  List<SinglePortfolioEntity> portfolioList = [];

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        scrollController: _scrollController,
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1000));
          // fetch prediction markets from the server and add to 'predictionMarkets'

          PortfoliosEntity portfolios = getPortfoliosTest();
          Map<int, SinglePortfolioEntity> portfolioMap =
              portfolios.portfoliosByMarketId[widget.marketMenu.marketId]!;
          portfolioList = portfolioMap.values.toList();
          // ---- FOR TEST ONLY ----
          setState(() {
            portfolioList = portfolioList;
            is_refreshing = false;
          });
          // ---- END OF FOR TEST ONLY ----

          _refreshController.refreshCompleted();
        },
        header: CustomHeader(
          refreshStyle: RefreshStyle.Behind,
          builder: (context, mode) {
            if (mode == RefreshStatus.refreshing) {
              return const SizedBox(
                height: 60,
                child: CupertinoActivityIndicator(),
              );
            } else {
              return Container();
            }
          },
        ),
        enablePullUp: false,
        child: (is_refreshing)
            ? const PortfolioShimmerWidget()
            : ListView.separated(
                itemBuilder: (context, index) {
                  return MarketDetailPortfolioInfo(
                      singlePortfolioEntity: portfolioList[index]);
                },
                separatorBuilder: ((context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width - 120,
                    height: 2,
                    color: CupertinoColors.systemGrey5,
                  );
                }),
                itemCount: portfolioList.length));
  }
}

class MarketDetailPortfolioInfo extends StatelessWidget {
  SinglePortfolioEntity singlePortfolioEntity;

  MarketDetailPortfolioInfo({super.key, required this.singlePortfolioEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 450,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0, bottom: 5, top: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 16,
                          child: Text(
                            singlePortfolioEntity.marketTitle,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: 'NotoSansCJKr',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.link,
                            ),
                          ),
                        ),
                        const Text(
                          "에 대한 내 예측",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: 'NotoSansCJKr',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: CupertinoColors.label,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    height: 130,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: CupertinoColors.systemGrey5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  (singlePortfolioEntity.shareTypeInt == 0)
                                      ? "그럴 것이다"
                                      : "아닐 것이다",
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'NotoSansCJKr',
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoColors.label,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4.0, left: 4),
                                  child: Icon(
                                    (singlePortfolioEntity.shareTypeInt == 0)
                                        ? CupertinoIcons.check_mark_circled
                                        : CupertinoIcons.xmark_circle,
                                    size: 25,
                                    weight: 300,
                                    color:
                                        (singlePortfolioEntity.shareTypeInt ==
                                                0)
                                            ? CupertinoColors.systemGreen
                                            : CupertinoColors.systemRed,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: singlePortfolioEntity.currentPrice
                                      .toStringAsFixed(0),
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'NotoSansCJKr',
                                    fontSize: 34,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.label,
                                  ),
                                  children: const [
                                    TextSpan(
                                      text: ' 원',
                                      style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: 'NotoSansCJKr',
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                        color: CupertinoColors.label,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PercentChangeIndicator2(
                                  changeRate: (singlePortfolioEntity
                                      .netBenefitInPercent),
                                  has_increased: singlePortfolioEntity
                                          .netBenefitInPercent >=
                                      0),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: PortfolioDetailedInfoRow(
                          title: '보유 예측 수',
                          content: singlePortfolioEntity.numberOfShares
                              .toStringAsFixed(2))),
                  PortfolioDetailedInfoRow(
                    title: '평균 예측 구입 가격',
                    content: singlePortfolioEntity.averagePurchasePrice
                        .toStringAsFixed(2),
                  ),
                  PortfolioDetailedInfoRow(
                    title: '수익률',
                    content:
                        '${singlePortfolioEntity.netBenefitInPercent.toStringAsFixed(2)}%',
                  ),
                  PortfolioDetailedInfoRow(
                    title: '미래 청산 가치*',
                    content:
                        '${singlePortfolioEntity.maxFutureResolveValuePerShare.toStringAsFixed(2)}원 또는 ${singlePortfolioEntity.minFutureResolveValuePerShare.toStringAsFixed(2)}원',
                  ),
                  PortfolioDetailedInfoRow(
                      title: (singlePortfolioEntity.shareTypeInt == 0)
                          ? '그럴 것이다 의 현재 확률'
                          : '아닐 것이다 의 현재 확률',
                      content:
                          '${singlePortfolioEntity.currentProbability.toStringAsFixed(2)}%'),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CupertinoButton(
                              padding: EdgeInsets.zero,
                              color: Colors.transparent,
                              child: Container(
                                width: 135,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: const Color(0xFF446CF8),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 3.0),
                                  child: Text(
                                    "추가로 사기",
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: 'NotoSansCJKr',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(
                                  builder: (context) {
                                    return OrderPage(
                                      marketId: singlePortfolioEntity.marketId,
                                      shareType:
                                          singlePortfolioEntity.shareTypeInt,
                                      is_sell: false,
                                    );
                                  },
                                ));
                              }),
                          CupertinoButton(
                              padding: EdgeInsets.zero,
                              color: Colors.transparent,
                              child: Container(
                                alignment: Alignment.center,
                                width: 135,
                                height: 40,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: const Color.fromARGB(255, 233, 70, 70),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 3.0),
                                  child: Text(
                                    "예측 팔기",
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: 'NotoSansCJKr',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: CupertinoColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(
                                  builder: (context) {
                                    return SellOrderPage(
                                      marketId: singlePortfolioEntity.marketId,
                                      shareType:
                                          singlePortfolioEntity.shareTypeInt,
                                      is_sell: true,
                                    );
                                  },
                                ));
                              })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class PortfolioDetailedInfoRow extends StatelessWidget {
  final String title;
  final String content;

  const PortfolioDetailedInfoRow({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'NotoSansCJKr',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 56, 56, 58),
            ),
          ),
          Text(
            content,
            style: const TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'NotoSansCJKr',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 56, 56, 58),
            ),
          )
        ],
      ),
    );
  }
}
