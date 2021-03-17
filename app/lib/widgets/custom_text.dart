import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  CustomText({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
