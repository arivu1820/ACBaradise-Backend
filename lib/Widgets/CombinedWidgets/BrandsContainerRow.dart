import 'package:acbaradise/Widgets/SingleWidgets/BrandsContainer.dart';
import 'package:flutter/material.dart';

class BrandsContainerRow extends StatelessWidget {
  const BrandsContainerRow({
    Key? key,
    required this.firstNumber,
    required this.secondNumber,
    required this.thirdNumber,
    required this.fourthNumber,
  }) : super(key: key);

  final num firstNumber;
  final num secondNumber;
  final num thirdNumber;
  final num fourthNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          BrandsContainer(number: firstNumber,),
          SizedBox(width: 10),
          BrandsContainer(number: secondNumber),
          SizedBox(width: 10),
          BrandsContainer(number: thirdNumber),
          SizedBox(width: 10),
          BrandsContainer(number: fourthNumber),
        ],
      ),
    );
  }
}