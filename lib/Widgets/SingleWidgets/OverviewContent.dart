import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';

class OverviewContent extends StatelessWidget {
  final List<dynamic>? overView;

  OverviewContent({required this.overView});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Overview and Specifications",
            style: TextStyle(
              fontFamily: "LexendRegular",
              fontSize: 14,
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (overView != null)
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: overView!.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${overView![index]}",
                      style: TextStyle(
                        fontFamily: "OxygenRegular",
                        fontSize: 12,
                        color: blackColor,
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
