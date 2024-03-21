import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class AMCTotalSparesContainer extends StatelessWidget {
  final List<dynamic>? TotalSparesContent;

  const AMCTotalSparesContainer({
    Key? key,
    required this.TotalSparesContent,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: lightBlueColor),
          color: whiteColor,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: RichText(
              text: TextSpan(
                text: '• ',
                style: TextStyle(
                  fontFamily: "LexendLight",
                  fontSize: 12,
                  color: blackColor,
                ),
                children: [
                  TextSpan(
                    text: TotalSparesContent![index],
                    style: const TextStyle(
                      fontFamily: "LexendLight",
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          itemCount: TotalSparesContent!.length,
        ),
      ),
    );
  }
}

