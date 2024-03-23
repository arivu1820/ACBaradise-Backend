import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class ServicePageBanner extends StatelessWidget {

final String Imageurl;

ServicePageBanner({required this.Imageurl});

  @override
  Widget build(BuildContext context) {
              double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: screenWidth*0.5,
      color: black5Color,
      child: Image.network(Imageurl,
        width: double.infinity,
        height: 200,fit: BoxFit.cover,
      ),
    );
  }
}
