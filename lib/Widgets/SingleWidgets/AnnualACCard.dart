import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';

class AnnualACCard extends StatelessWidget {
  final bool condition;
  final String name;
  final String img;
  

  AnnualACCard({required this.condition,required this.name,required this.img});
 
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          height: condition ? 120 : 100,
          width: condition ? 120 : 100,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: condition ? Colors.transparent : lightGrayColor,
              width: 0.3,
            ),
            boxShadow: [
              BoxShadow(
                color: condition ? lightBlue50Color : Colors.transparent,
                offset: Offset(0, 0),
                blurRadius: condition ? 10.0 : 0.0,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: SizedBox(
              height: condition? 100: 80,
              width: condition? 100: 80,
              child: Image.network(img,fit: BoxFit.cover,),
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Text(
              name,
              style: TextStyle(
                fontFamily: condition? "LexendMedium": "LexendRegular",
                fontSize: condition? 14 : 12,
                color: blackColor,
              ),
            ),
      ],
    );
  }
}
