import 'package:SpaceX_Launcher/widgets/countdown_numbers.dart';
import 'package:SpaceX_Launcher/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CountDownBox extends StatelessWidget {
  final String timeRemaining;
  final String text;
  CountDownBox({this.timeRemaining, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CountDownNumbers(
            text: timeRemaining,
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomText(
            text: text,
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
