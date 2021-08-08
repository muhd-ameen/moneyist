import 'package:flutter/material.dart';

class TitleHead extends StatelessWidget {
  const TitleHead({
    this.Title,
    this.money,
  });
  final Title;
   final money;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Title,
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '$money',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ],
    );
  }
}
