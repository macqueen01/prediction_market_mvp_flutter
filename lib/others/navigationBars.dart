import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/OrderPages/OrderPage.dart';

class MainPageBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  const MainPageBottomNavigationBar({super.key, required this.selectedIndex});

  @override
  Widget build(context) {
    return Hero(
      tag: 'main-page-bottom-navigation-bar',
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
            color: CupertinoColors.systemBackground,
            border: Border(
                top: BorderSide(
              color: CupertinoColors.systemGrey5,
              width: 0.5,
            ))),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          (selectedIndex == 0)
                              ? CupertinoIcons.graph_square_fill
                              : CupertinoIcons.graph_square,
                          color: (selectedIndex == 0)
                              ? const Color.fromARGB(255, 93, 93, 96)
                              : CupertinoColors.systemGrey3,
                          size: 35,
                        ),
                        Text(
                          "예측시장",
                          style: TextStyle(
                            color: (selectedIndex == 0)
                                ? const Color.fromARGB(255, 93, 93, 96)
                                : CupertinoColors.systemGrey3,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          (selectedIndex == 1)
                              ? CupertinoIcons.money_dollar_circle_fill
                              : CupertinoIcons.money_dollar_circle,
                          color: (selectedIndex == 1)
                              ? const Color.fromARGB(255, 93, 93, 96)
                              : CupertinoColors.systemGrey3,
                          size: 35,
                        ),
                        Text(
                          "출금하기",
                          style: TextStyle(
                            color: (selectedIndex == 1)
                                ? const Color.fromARGB(255, 93, 93, 96)
                                : CupertinoColors.systemGrey3,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/withdraw');
                  }),
              CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          (selectedIndex == 2)
                              ? CupertinoIcons.person_crop_circle_fill
                              : CupertinoIcons.person_crop_circle,
                          color: (selectedIndex == 2)
                              ? const Color.fromARGB(255, 93, 93, 96)
                              : CupertinoColors.systemGrey3,
                          size: 35,
                        ),
                        Text(
                          "포트폴리오",
                          style: TextStyle(
                            color: (selectedIndex == 2)
                                ? const Color.fromARGB(255, 93, 93, 96)
                                : CupertinoColors.systemGrey3,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/user-profile', (route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class MarketDetailBottomNavigationBar extends StatelessWidget {
  MarketDetailBottomNavigationBar({super.key, required this.marketEntity});

  PredictionMarketMenuEntity marketEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: CupertinoColors.systemBackground,
          border: Border(
              top: BorderSide(
            color: CupertinoColors.systemGrey5,
            width: 0.5,
          ))),
      height: 95,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "*예측은 '내가 산 예측' 탭에서 팔 수 있습니다.",
                style: TextStyle(
                    color: CupertinoColors.systemGrey3,
                    fontSize: 10,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoButton(
                  color: const Color(0xFF446CF8),
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) {
                        return OrderPage(
                          marketId: marketEntity.marketId,
                          shareType: 0,
                          is_sell: false,
                        );
                      },
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      '그럴 것이다 사기',
                      style: TextStyle(
                        color: CupertinoColors.systemBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                CupertinoButton(
                  color: const Color.fromARGB(255, 233, 70, 70),
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) {
                        return OrderPage(
                          marketId: marketEntity.marketId,
                          shareType: 1,
                          is_sell: false,
                        );
                      },
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      '아닐 것이다 사기',
                      style: TextStyle(
                        color: CupertinoColors.systemBackground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
