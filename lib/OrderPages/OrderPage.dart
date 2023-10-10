import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:perdiction_market_mvp/others/KeyboardKey.dart';
import 'package:perdiction_market_mvp/predictionMarketMenu.dart';
import 'package:perdiction_market_mvp/utils.dart';

class DummyBuyOrderPageTestRoute extends StatelessWidget {
  DummyBuyOrderPageTestRoute({super.key});

  int marketId = 0;
  int shareType = 0;
  bool is_sell = false;

  @override
  Widget build(BuildContext context) {
    return OrderPage(marketId: marketId, is_sell: is_sell);
  }
}

class OrderPage extends StatefulWidget {
  int marketId;
  int shareType;
  bool is_sell;

  OrderPage(
      {super.key,
      required this.marketId,
      this.shareType = 0,
      required this.is_sell});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late List<List<dynamic>> keys;
  late String amount;

  // Buy Order Execution
  Future buy() async {
    // http request to server
    // then get the result.
    Loader.show(
      context,
      progressIndicator: const CupertinoActivityIndicator(),
      overlayColor: const Color.fromARGB(84, 150, 150, 150),
    );
  }

  @override
  void initState() {
    super.initState();

    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['00', '0', const Icon(Icons.keyboard_backspace)],
    ];

    amount = '';
  }

  onKeyTap(val) {
    if (val == '0' && amount.isEmpty) {
      return;
    }

    setState(() {
      amount = amount + val;
    });
  }

  onBackspacePress() {
    if (amount.isEmpty) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map(
              (y) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: KeyboardKey(
                      label: y,
                      value: y,
                      onTap: (val) {
                        if (val is Widget) {
                          onBackspacePress();
                        } else {
                          onKeyTap(val);
                        }
                      },
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }

  renderAmount() {
    String display = '예측할 금액';
    TextStyle style = const TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    if (amount.isNotEmpty) {
      NumberFormat f = NumberFormat('#,###');

      display = '${f.format(int.parse(amount))}원';
      style = style.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }

  renderMarketInfo() {
    // Fetch from server

    // --- To be implemented ---

    dummyFuture() async {
      await Future.delayed(const Duration(seconds: 1));
      return {
        'title': '삼성전자',
        'imageUrl':
            'https://imgnews.pstatic.net/image/421/2021/08/11/0005522884_001_20210811110003600.jpg?type=w647',
      };
    }

    // --- Fetch to be implemented above ---

    Widget MarketHeader({
      required String imageUrl,
      required String title,
    }) {
      return Container(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          width: 325,
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MarketImageHolder(image: imageUrl, is_new: false),
                  Container(
                    width: 220,
                    height: 60,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
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
              ),
              Text(
                (widget.shareType == 0 ? '"그럴 것이다"' : '"아닐 것이다"'),
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'NotoSansCJKr',
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                ),
              )
            ],
          ));
    }

    return FutureBuilder(
      future: dummyFuture(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MarketHeader(
            imageUrl: snapshot.data!['imageUrl']!,
            title: snapshot.data!['title']!,
          );
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return BoxShimmer(width: 325, height: 130);
        }
      },
    );
  }

  renderCurrentAsset() {
    // Fetch from server

    // --- To be implemented ---

    dummyFuture() async {
      await Future.delayed(const Duration(seconds: 1));
      return 1000000;
    }

    // --- Fetch to be implemented above ---

    Widget errorWidget = Container(
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: CupertinoColors.systemGrey5,
        ),
        child: const Padding(
          padding:
              EdgeInsets.only(top: 0.0, left: 15, right: 15, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "네트워크 오류",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansCJKr',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.systemRed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));

    currentAssetContainer(int value) => Container(
        width: 320,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: CupertinoColors.systemGrey5,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0.0, left: 15, right: 15, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "보유 금액",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansCJKr',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 73, 73, 74),
                    ),
                  ),
                  Text(
                    "$value 원",
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'NotoSansCJKr',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 73, 73, 74),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));

    return FutureBuilder(
      future: dummyFuture(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return currentAssetContainer(snapshot.data as int);
        } else if (snapshot.hasError) {
          return errorWidget;
        } else {
          return BoxShimmer(width: 320, height: 60);
        }
      },
    );
  }

  renderConfirmButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: CupertinoButton(
              color: const Color.fromARGB(255, 123, 61, 204),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              onPressed: amount.isNotEmpty
                  ? () {
                      buy();
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  '확인',
                  style: TextStyle(
                    color: amount.isNotEmpty ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.systemBackground,
          border: Border.all(color: CupertinoColors.systemBackground),
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
          middle: const Text(
            '예측 주문',
            style: TextStyle(
              color: CupertinoColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: CupertinoColors.systemBackground,
        child: SafeArea(
          child: Material(
            color: CupertinoColors.systemBackground,
            child: Column(
              children: [
                renderMarketInfo(),
                renderAmount(),
                renderCurrentAsset(),
                ...renderKeyboard(),
                renderConfirmButton(),
              ],
            ),
          ),
        ));
  }
}
