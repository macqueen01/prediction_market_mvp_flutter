import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perdiction_market_mvp/WithdrawPages/WithdrawPage.dart';
import 'package:perdiction_market_mvp/others/KeyboardKey.dart';

class WithdrawOrderPageRoute extends StatelessWidget {
  const WithdrawOrderPageRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const WriteBankAccountPage();
  }
}

class WriteBankAccountPage extends StatefulWidget {
  const WriteBankAccountPage({super.key});

  @override
  _WriteBankAccountPageState createState() => _WriteBankAccountPageState();
}

class _WriteBankAccountPageState extends State<WriteBankAccountPage> {
  late List<List<dynamic>> keys;
  late String amount;

  @override
  void initState() {
    super.initState();

    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', const Icon(Icons.keyboard_backspace)],
    ];

    amount = '';
  }

  onKeyTap(val) {
    if (val == '') {
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
    String display = '인출할 계좌 번호';
    TextStyle style = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    if (amount.isNotEmpty) {
      display = amount;
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
              onPressed: amount.isNotEmpty
                  ? () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                        return WithdrawPage(bankAccount: amount);
                      }));
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
                      '데쟈에서는 인출 가능하나 입금은 불가능 합니다. 또한, 잘못된 인출 계좌 입력시 복구가 불가능할 수 있습니다. 정확한 계좌번호를 입력해주세요.',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'NotoSansCJKr',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: CupertinoColors.systemGrey3,
                      ),
                    )),
                renderAmount(),
                ...renderKeyboard(),
                renderConfirmButton(),
              ],
            ),
          ),
        ));
  }
}
