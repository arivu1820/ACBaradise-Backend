import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class AdvantagesContainer extends StatelessWidget {
  final bool showImageFirst;
  final String imageurl;
  final String content;

  const AdvantagesContainer(
      {Key? key,
      required this.showImageFirst,
      required this.imageurl,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showImageFirst)
            Image.network(
              imageurl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                  fontFamily: "LexendLight", fontSize: 14, color: blackColor),
            ),
          ),
          if (!showImageFirst)
            Image.network(
              imageurl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
