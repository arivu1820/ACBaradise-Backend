import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AdvantagesContainer.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AdvantagesCostandSpares.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SimplyExpand.dart';
import 'package:flutter/material.dart';

class AMCAdvantages extends StatelessWidget {
  final bool isOnlyAdvantages;
final int discount;
  final int mrp;
  final int TotalSparesMRP;
  final String title;
  final List<dynamic>? images;
  final List<dynamic>? benefits;
  final List<dynamic>? TotalSparesContent;
  final String Serviceid;
  final String uid;

  AMCAdvantages(
      {required this.isOnlyAdvantages,
      required this.mrp,
      required this.discount,
      required this.title,
      required this.images,
      required this.benefits,
      required this.TotalSparesContent,
      required this.TotalSparesMRP,
      required this.Serviceid,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontFamily: "LexendRegular",
                          fontSize: 18,
                          color: blackColor),
                    ),
                    Expanded(
                      child: const SizedBox(
                        width: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        "Assets/Icons/Close_Cross_Icon.png",
                        width: 30,
                        height: 30,
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: lightBlueColor),
                  ),
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // Check if the index is within the bounds of the images list
                      if (index % 2 == 0) {
                        return AdvantagesContainer(
                          showImageFirst: true,
                          imageurl: images![index],
                          content: benefits![index],
                        );
                      } else {
                        return AdvantagesContainer(
                          showImageFirst: false,
                          imageurl: images![index],
                          content: benefits![index],
                        );
                      }
                    },
                    itemCount: images?.length ?? 0,
                  ),
                ),
                isOnlyAdvantages
                    ? const SizedBox(
                        height: 20,
                      )
                    : const SizedBox(
                        height: 170,
                      ),
              ],
            ),
          ),
        ),
        isOnlyAdvantages
            ? SizedBox()
            : Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AdvantagesCostandSpares(
                  discount: discount,
                  mrp: mrp,
                  TotalSparesContent: TotalSparesContent,
                  TotalSparesMRP: TotalSparesMRP,
                  Serviceid: Serviceid,
                  Servicetitle: title,
                  uid: uid,
                ),
              )
      ],
    );
  }
}
