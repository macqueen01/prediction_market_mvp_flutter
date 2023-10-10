import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/PredictionMarketDetailPage.dart';
import 'package:perdiction_market_mvp/others/navigationBars.dart';
import 'package:perdiction_market_mvp/predictionMarketMenu.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class PredictionMarketListView extends StatefulWidget {
  ScrollController scrollController;

  PredictionMarketListView(
      {super.key, required this.scrollController});

  @override
  State<PredictionMarketListView> createState() =>
      _PredictionMarketListViewState();
}

class _PredictionMarketListViewState extends State<PredictionMarketListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<PredictionMarketMenuEntity> predictionMarkets = [];

  get _isEmpty => predictionMarkets.isEmpty;

  // ---- Props for the 'PredictionMarketTile' widget ----

  // IMPORTANT: This section should be removed in production.

  // Mock pool state for the prediction market
  PoolStateEntity poolState = PoolStateEntity(
    marketId: 0,
    positiveShares: 30,
    negativeShares: 70,
    positiveSharesAtLastUpdate: 28,
    negativeSharesAtLastUpdate: 80,
  );

  // Mock market menu entity for the prediction market
  PredictionMarketMenuEntity marketMenu = PredictionMarketMenuEntity(
      marketId: 0,
      title: '2024년 대한민국 제 22대 총선에서 다수당이 될 정당은 민주당인가?',
      description:
          '2024년 4월 10일에 실시될 대한민국 국회의원 선거.\n2024년 상반기 재보궐선거와 동시에 시행된다.\n관련 법안이 개정되지 않는 한 2006년 4월 11일생까지, 18세 이상의 대한민국 국민에게 선거권과 피선거권이 주어진다.\n윤석열 대통령의 취임 후 대략 2년 만에 실시하는 선거로서, 향후 국정 동력을 결정할 중간선거 격 선거이다.\n집권 여당인 국민의힘은 정부 입법 추진 등 국정 동력을 얻기 위해, 제1야당인 더불어민주당은 정권 견제 능력을 유지하기 위해, 각각 제2야당과 제3야당인 정의당과 진보당은 진보 세력을 규합하고 발언권을 보장받기 위해 노력할 것으로 보인다.\n2018년 제7회 전국동시지방선거 이후 전국 단위 선거에서 6년 만에 노마스크 상태로 투표할 수 있을 예정이다.',
      image: 'https://picsum.photos/250?image=9',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      is_resolved: false);

  // ---- End of props for the 'PredictionMarketTile' widget ----

  @override
  void initState() {
    super.initState();
    // fetch prediction markets from the server and add to 'predictionMarkets'

    // ---- FOR TEST ONLY ----
    setState(() {
      marketMenu.poolState = poolState;
      predictionMarkets.add(marketMenu);
    });
    // ---- END OF FOR TEST ONLY ----
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      scrollController: widget.scrollController,
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));
        // fetch prediction markets from the server and add to 'predictionMarkets'

        // ---- FOR TEST ONLY ----
        setState(() {
          marketMenu.poolState = poolState;
          predictionMarkets.add(marketMenu);
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
      child: (_isEmpty)
          ? const Center(
              child: Text('예측시장이 없습니다.'),
            )
          : ListView.builder(
              itemCount: predictionMarkets.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(
                      builder: (context) {
                        return PredictionMarketPage(
                          marketMenuEntity: predictionMarkets[index],
                        );
                      },
                    ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: PredictionMarketTile(
                          marketMenu: predictionMarkets[index],
                          poolState: predictionMarkets[index].poolState!,
                        )),
                  ),
                );
              },
            ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({super.key});

  ScrollController mainScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      bottomNavigationBar: const MainPageBottomNavigationBar(
        selectedIndex: 0,
      ),
      body: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemBackground,
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoColors.systemBackground,
              border: Border.all(color: CupertinoColors.systemBackground),
              stretch: true,
              largeTitle: const Text('예측시장'),
            ),
            SliverFillRemaining(
                child: PredictionMarketListView(
              scrollController: mainScrollController,
            ))
          ],
        ),
      ),
    );
  }
}
