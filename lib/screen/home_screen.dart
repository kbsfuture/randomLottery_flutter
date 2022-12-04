import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:startup/component/number_row.dart';
import 'package:startup/constant/color.dart';
import 'package:startup/screen/settings_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int maxNumber = 1000;
  List<int> randomNumbers = [];

  void onRandomNumberGenerate() {
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _Header(
                  onPressed: onSettingsPop,
                ),
                _Body(randomNumbers: randomNumbers),
                _Footer(onPressed: onRandomNumberGenerate),
              ],
            ),
          ),
        ));
  }

  void onSettingsPop() async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingsScreen(
            maxNumber: maxNumber,
          );
        },
      ),
    );
    setState(() {
      if (result != null) {
        maxNumber = result;
      }
    });
    // 새로운 screen을 router stack에 push
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('렌덤숫자 생성기',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700)),
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.settings,
              color: RED_COLOR,
            )),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumbers;
  const _Body({required this.randomNumbers, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap()
            .entries
            .map((y) => Padding(
                padding: EdgeInsets.only(bottom: y.key == 2 ? 0 : 16.0),
                child: NumberRow(
                  number: y.value,
                )))
            .toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              '생성하기',
            ),
            style: ElevatedButton.styleFrom(primary: RED_COLOR)));
  }
}
