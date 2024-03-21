import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';

class SpecificationContent extends StatelessWidget {
  final Map<dynamic, dynamic>? specifications;

  SpecificationContent({Key? key, required this.specifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: darkGreyColor, width: 1),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: specifications?.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "${entry.key}",
                          style: TextStyle(
                            fontFamily: "LexendMedium",
                            fontSize: 12,
                            color: blackColor,
                          ),
                        ),
                      ],
                    );
                  }).toList() ?? [],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: specifications?.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          "${entry.value}",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: "OxygenRegular",
                            fontSize: 12,
                            color: blackColor,
                          ),
                        ),
                      ],
                    );
                  }).toList() ?? [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
