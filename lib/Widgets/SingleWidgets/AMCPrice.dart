import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:intl/intl.dart';

class AMCPrice extends StatelessWidget {
  final int discount;
  final int mrp;
  const AMCPrice({super.key, required this.discount, required this.mrp});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              '₹ ${NumberFormat('#,##,###').format((mrp - (mrp * discount / 100)).ceilToDouble())}  ',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "LexendMedium",
                color: blackColor,
              ),
            ),
            Text(
              '${NumberFormat('#,##,###').format(mrp)}',
              style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "LexendRegular",
                  color: black50Color,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: black50Color, // Set the color to black
                  decorationStyle: TextDecorationStyle.solid),
            ),
          ],
        ),
        const SizedBox(
          width: 5,
        ),
        IconTheme(
          data: IconThemeData(
            size: 20.0, // Set the size to 20 pixels
          ),
          child: Image.asset(
            'Assets/Icons/ArrowRight.png', // Replace with the correct path to your image asset
            width: 10.0, // Set the width to match the desired size
            height: 20.0, // Set the height to match the desired size
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
