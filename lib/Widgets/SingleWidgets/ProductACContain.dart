import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class ProductACContainer extends StatelessWidget {
  final String imageUrl;
ProductACContainer({required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180,
        height: 230,
        decoration: BoxDecoration(
          color: lightGray25Color,
          
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            width: 160,
            height: 61,
            decoration: BoxDecoration(
                // Add decoration properties for the inner container if needed
                ),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
