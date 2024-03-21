import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class ProductContent extends StatelessWidget {
  final String ProductName;

  ProductContent({required this.ProductName});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Text(ProductName,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "LexendRegular",
                  color: blackColor,
                ),
            
      ),
    );
  }
}