import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perdiction_market_mvp/Entities/PredictionMarketEntities.dart';
import 'package:perdiction_market_mvp/PredictionMarketDetailPage.dart';
import 'package:perdiction_market_mvp/api.dart';
import 'package:perdiction_market_mvp/others/navigationBars.dart';
import 'package:perdiction_market_mvp/predictionMarketMenu.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class PredictionMarketListView extends StatefulWidget {
  ScrollController scrollController;

  PredictionMarketListView({super.key, required this.scrollController});

  @override
  State<PredictionMarketListView> createState() =>
      _PredictionMarketListViewState();
}

class _PredictionMarketListViewState extends State<PredictionMarketListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<PredictionMarketMenuEntity> predictionMarkets = [];

  get _isEmpty => predictionMarkets.isEmpty;

  void fetchMarketsAndAdd() {
    Future<List<PredictionMarketMenuEntity>> loadedMarkets =
        Api().fetchMarkets();
    loadedMarkets.then((value) {
      value.forEach((market) {
        if (!(predictionMarkets
            .map((e) => e.marketId)
            .contains(market.marketId))) {
          predictionMarkets.add(market);
        }
      });
      setState(() {
        predictionMarkets = predictionMarkets;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // fetch prediction markets from the server and add to 'predictionMarkets'
    fetchMarketsAndAdd();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      scrollController: widget.scrollController,
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1000));

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
              child: Text(
                '예측시장이 없습니다.',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 91, 91, 91),
                ),
              ),
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
