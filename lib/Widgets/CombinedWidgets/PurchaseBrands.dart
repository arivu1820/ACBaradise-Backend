import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/BrandsContainerRow.dart';
import 'package:flutter/material.dart';

class PurchaseBrands extends StatelessWidget {
  const PurchaseBrands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      margin: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Discover Your Brand's",
            style: TextStyle(
              fontSize: 16,
              fontFamily: "LexendRegular",
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BrandsContainerRow(firstNumber: 1, secondNumber: 2, thirdNumber: 3, fourthNumber:4),
          const SizedBox(
            height: 10,
          ),
           BrandsContainerRow(firstNumber: 5, secondNumber: 11, thirdNumber: 6,fourthNumber:7),
          const SizedBox(
            height: 10,
          ),
           BrandsContainerRow(firstNumber: 8, secondNumber: 12, thirdNumber:9 ,fourthNumber:10),
         
        ],
      ),
    );
  }
}