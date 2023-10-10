import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:perdiction_market_mvp/Entities/Portfolios.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/PredictionMarketDetailPage.dart';
import 'package:perdiction_market_mvp/others/navigationBars.dart';
import 'package:perdiction_market_mvp/predictionMarketMenu.dart';
import 'package:perdiction_market_mvp/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool _is_refreshing = true;

  PortfoliosEntity portfolios = PortfoliosEntity();

  Future<void> navigateToMarket({required marketId}) async {
    // fetch data and encapsulate to Prediction Market Menu Entity

    Loader.show(
      context,
      progressIndicator: const CupertinoActivityIndicator(),
      overlayColor: const Color.fromARGB(84, 150, 150, 150),
    );

    // IMPORTANT: This section should be removed in production.

    dummyFuture() async {
      return Future.delayed(const Duration(seconds: 1));
    }

    PredictionMarketMenuEntity marketEntity = PredictionMarketMenuEntity(
        marketId: 0,
        title: '2024년 대한민국 제 22대 총선에서 다수당이 될 정당은 민주당인가?',
        description:
            '2024년 4월 10일에 실시될 대한민국 국회의원 선거.\n2024년 상반기 재보궐선거와 동시에 시행된다.\n관련 법안이 개정되지 않는 한 2006년 4월 11일생까지, 18세 이상의 대한민국 국민에게 선거권과 피선거권이 주어진다.\n윤석열 대통령의 취임 후 대략 2년 만에 실시하는 선거로서, 향후 국정 동력을 결정할 중간선거 격 선거이다.\n집권 여당인 국민의힘은 정부 입법 추진 등 국정 동력을 얻기 위해, 제1야당인 더불어민주당은 정권 견제 능력을 유지하기 위해, 각각 제2야당과 제3야당인 정의당과 진보당은 진보 세력을 규합하고 발언권을 보장받기 위해 노력할 것으로 보인다.\n2018년 제7회 전국동시지방선거 이후 전국 단위 선거에서 6년 만에 노마스크 상태로 투표할 수 있을 예정이다.',
        image: 'https://picsum.photos/250?image=9',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        is_resolved: false);

    PoolStateEntity poolState = PoolStateEntity(
      marketId: 0,
      positiveShares: 30,
      negativeShares: 70,
      positiveSharesAtLastUpdate: 28,
      negativeSharesAtLastUpdate: 80,
    );

    marketEntity.poolState = poolState;
    await dummyFuture();

    // End of mock data

    Loader.hide();

    Navigator.push(context, CupertinoPageRoute(builder: ((context) {
      return PredictionMarketPage(
        marketMenuEntity: marketEntity,
      );
    })));
  }

  Widget portfolioInfoRow(
      {required String title, required Text content, required double width}) {
    return SizedBox(
      width: width,
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
          content
        ],
      ),
    );
  }

  renderPortfolioList(PortfoliosEntity portfolios, BuildContext context) {
    List<Widget> portfolioList = [];

    portfolios.portfoliosByMarketId.forEach((key, value) {
      value.forEach((key, value) {
        portfolioList.add(renderPortfolioItem(value, context));
      });
    });

    return portfolioList;
  }

  Widget renderPortfolioItem(
      SinglePortfolioEntity portfolioEntity, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: GestureDetector(
        onTap: () {
          navigateToMarket(marketId: portfolioEntity.marketId);
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 60,
          height: 255,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: CupertinoColors.systemGrey5,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 325,
                  height: 100,
                  child: Column(children: [
                    Container(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        width: 325,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MarketImageHolder(
                                image: portfolioEntity.marketImage,
                                is_new: false),
                            Container(
                              width: 220,
                              height: 60,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                portfolioEntity.marketTitle,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'NotoSansCJKr',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                      width: 325,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 80, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (portfolioEntity.shareTypeInt == 0)
                                  ? '그럴 것이다'
                                  : '아닐 것이다',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'NotoSansCJKr',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 56, 56, 58),
                              ),
                            ),
                            Icon(
                              CupertinoIcons.chevron_right,
                              size: 18,
                              color: Color.fromARGB(255, 56, 56, 58),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 1,
                    color: CupertinoColors.systemBackground),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        portfolioInfoRow(
                            title: '평가손익',
                            content: Text(
                              (portfolioEntity.netBenefit > 0)
                                  ? '+' +
                                      (portfolioEntity.netBenefit)
                                          .toStringAsFixed(2)
                                  : (portfolioEntity.netBenefit)
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'NotoSansCJKr',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: (portfolioEntity.netBenefit < 0)
                                    ? Color.fromARGB(255, 0, 122, 255)
                                    : Color.fromARGB(255, 255, 59, 48),
                              ),
                            ),
                            width: 280),
                        portfolioInfoRow(
                            title: '수익률',
                            content: Text(
                                (portfolioEntity.netBenefitInPercent > 0)
                                    ? '+' +
                                        portfolioEntity.netBenefitInPercent
                                            .toStringAsFixed(2) +
                                        '%'
                                    : portfolioEntity.netBenefitInPercent
                                            .toStringAsFixed(2) +
                                        '%',
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: 'NotoSansCJKr',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: (portfolios.getTotalNetBenefit() < 0)
                                      ? Color.fromARGB(255, 0, 122, 255)
                                      : Color.fromARGB(255, 255, 59, 48),
                                )),
                            width: 280),
                        portfolioInfoRow(
                            title: '투자금액',
                            content: Text(
                                portfolioEntity.averagePurchasePrice
                                    .toStringAsFixed(2),
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'NotoSansCJKr',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 56, 56, 58))),
                            width: 280),
                        portfolioInfoRow(
                            title: '현재확률',
                            content: Text(
                                portfolioEntity.currentProbability
                                        .toStringAsFixed(2) +
                                    '%',
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'NotoSansCJKr',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 56, 56, 58))),
                            width: 280)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderPortfolioInfoDetail(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 70;
    return Container(
      width: width,
      height: 120,
      child: Column(
        children: [
          portfolioInfoRow(
              title: '평가손익',
              content: Text(
                (portfolios.getTotalNetBenefit() > 0)
                    ? '+' + portfolios.getTotalNetBenefit().toStringAsFixed(2)
                    : portfolios.getTotalNetBenefit().toStringAsFixed(2),
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: (portfolios.getTotalNetBenefit() < 0)
                      ? Color.fromARGB(255, 0, 122, 255)
                      : Color.fromARGB(255, 255, 59, 48),
                ),
              ),
              width: width),
          portfolioInfoRow(
              title: '수익률',
              content: Text(
                  (portfolios.getTotalNetBenefit() > 0)
                      ? '+' +
                          portfolios
                              .getTotalNetBenefitInPercent()
                              .toStringAsFixed(2)
                      : portfolios
                          .getTotalNetBenefitInPercent()
                          .toStringAsFixed(2),
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: 'NotoSansCJKr',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: (portfolios.getTotalNetBenefit() < 0)
                        ? Color.fromARGB(255, 0, 122, 255)
                        : Color.fromARGB(255, 255, 59, 48),
                  )),
              width: width),
          portfolioInfoRow(
              title: '총 투자금액',
              content: Text(
                  this.portfolios.getTotalInvestment().toStringAsFixed(2),
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansCJKr',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 56, 56, 58))),
              width: width),
          portfolioInfoRow(
              title: '보유 현금',
              content: Text(this.portfolios.usableCash.toStringAsFixed(2),
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansCJKr',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 56, 56, 58))),
              width: width)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      appBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.systemBackground,
        border: Border.all(color: CupertinoColors.systemBackground),
        automaticallyImplyLeading: false,
        middle: Text(
          '내 프로필',
          style: TextStyle(
            color: CupertinoColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: const MainPageBottomNavigationBar(selectedIndex: 2),
      body: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemBackground,
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              portfolios = getPortfoliosTest();
              _refreshController.refreshCompleted();
              _is_refreshing = false;
              setState(() {});
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
            child: (_is_refreshing)
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 70,
                    height: 240,
                    child: BoxShimmer(
                        width: MediaQuery.of(context).size.width - 70,
                        height: 240),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 240,
                          color: CupertinoColors.systemBackground,
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 90,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "총 보유 자산",
                                            style: TextStyle(
                                              fontFamily: 'NotoSansCJKr',
                                              color: Color.fromARGB(
                                                  255, 56, 56, 58),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: portfolios
                                                  .getEntireAssetValue()
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontFamily: 'NotoSansCJKr',
                                                color: Color.fromARGB(
                                                    255, 56, 56, 58),
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                            TextSpan(
                                              text: " 원",
                                              style: TextStyle(
                                                fontFamily: 'NotoSansCJKr',
                                                color: Color.fromARGB(
                                                    255, 56, 56, 58),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ])),
                                      const Text(
                                        "유저 아이디: 12947652",
                                        style: TextStyle(
                                          fontFamily: 'NotoSansCJKr',
                                          color:
                                              Color.fromARGB(255, 56, 56, 58),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 70,
                                    height: 2,
                                    color: CupertinoColors.systemGrey3),
                                // Total Asset Analysis

                                renderPortfolioInfoDetail(context)
                              ],
                            ),
                          ),
                        ),
                        ...renderPortfolioList(portfolios, context)
                      ],
                    ),
                  ),
          )),
    );
  }
}
