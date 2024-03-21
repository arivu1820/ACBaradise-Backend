
import 'package:acbaradise/Widgets/CombinedWidgets/AMCAdvantages.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AMCPrice.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/widgets.dart';

class AnnualSchemeContainer extends StatelessWidget {
  final String content;
  final int discount;
  final int mrp;
  final int TotalSparesMRP;
  final String title;
  final List<dynamic>? images;
  final List<dynamic>? benefits;
  final List<dynamic>? TotalSparesContent;
    final String Serviceid;
  final String uid;
  const AnnualSchemeContainer(
      {super.key,
      required this.content,
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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled:
              true, // Allows the modal to cover the entire screen height
          backgroundColor: Colors
              .transparent, // Set to transparent to make the rounded corners visible

          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height *
                  0.9, // Set the height to 70% of the screen height
              decoration: BoxDecoration(
                color: whiteColor, // Set the background color to white
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0)), // Add rounded corners
              ),
              child: AMCAdvantages(
                isOnlyAdvantages: false,
                images: images,
                benefits: benefits,
                discount: discount,
                mrp: mrp,
                title: title,
                TotalSparesContent: TotalSparesContent,
                TotalSparesMRP: TotalSparesMRP,
                Serviceid: Serviceid,
                uid: uid,
              ),
            );
          },
        );
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        padding: const EdgeInsets.only(left: 20, top: 0, bottom: 5, right: 10),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: lightBlue75Color,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "LexendRegular",
                        fontSize: 18,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  '$discount% off',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: "LexendMedium",
                    fontSize: 20,
                    color: darkBlueColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                    child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: "LexendRegular",
                      fontSize: 12,
                      color: black60Color,
                    ),
                    children: [
                      TextSpan(
                        text: content,
                      ),
                      TextSpan(
                        text: "More",
                        style: const TextStyle(
                          color:
                              darkBlueColor, // Replace with your desired bold color
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Add your onTap functionality here
                            print("Second part clicked!");
                          },
                      ),
                    ],
                  ),
                )),
                const SizedBox(
                  width: 40,
                ),
                AMCPrice(
                  discount:discount,
                  mrp: mrp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
