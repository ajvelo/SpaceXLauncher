import 'package:flutter/material.dart';

class CountDownNumbers extends StatelessWidget {
  final String text;
  CountDownNumbers({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
