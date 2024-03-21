import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class ServicesContainer extends StatelessWidget {
  final String serviceName;
  final String imageUrl;

  const ServicesContainer({required this.serviceName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: lightGrayColor, width: 0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                serviceName,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "LexendMedium",
                  color: blackColor,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Container(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              height: 75,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
