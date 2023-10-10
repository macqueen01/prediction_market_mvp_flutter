import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:perdiction_market_mvp/others/KeyboardKey.dart';
import 'package:perdiction_market_mvp/utils.dart';

class WithdrawPage extends StatefulWidget {
  String bankAccount;
  WithdrawPage({super.key, required this.bankAccount});

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  late List<List<dynamic>> keys;
  late String amount;

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

  renderCurrentAsset() {
    // Fetch from server

    dummyFuture() async {
      await Future.delayed(const Duration(seconds: 1));
      return 1000000;
    }

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
    String display = '보낼금액';
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

  renderConfirmButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 5, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: CupertinoButton(
              color: const Color.fromARGB(255, 123, 61, 204),
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
              onPressed: amount.isNotEmpty ? () {} : null,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  '인출하기',
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
            '인출하기',
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
                Container(
                    clipBehavior: Clip.none,
                    alignment: Alignment.centerLeft,
                    width: 330,
                    height: 120,
                    child: const Text(
                      '데쟈에서는 인출 가능하나 입금은 불가능 합니다. 따라서 모든 금액을 인출하게 되면, 다시는 데쟈에서 예측을 하실 수 없습니다.\n인출하시겠습니까?',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'NotoSansCJKr',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.systemGrey3,
                      ),
                    )),
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
