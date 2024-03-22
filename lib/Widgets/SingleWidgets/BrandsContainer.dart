import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class BrandsContainer extends StatelessWidget {
  final num number;

  const BrandsContainer({
    Key? key,
    required this.number,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 40;
    double containerHeight = screenWidth / 5;
    double containerWidth = (screenWidth - 30) / 4;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: lightBlueBrandColor,
      ),
      height: containerHeight,
      width: containerWidth,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          "Assets/Icons/B$number.png",
        ),
      ),
    );
  }
}