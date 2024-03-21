import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AMCAdvantages.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CopyBox.dart';
import 'package:acbaradise/Widgets/SingleWidgets/DottedLine.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SerciceCount.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ServiceClaim.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoreViewSubscriptionScheme extends StatelessWidget {
  final bool isService;
  final String uid;
  final List benefitsList;
  final List imagesList;

  final Timestamp service1Timestamp;
  final Timestamp service2Timestamp;
  final Timestamp service3Timestamp;
  final Timestamp service4Timestamp;
  final bool isDone1;
  final bool isDone2;
  final bool isDone3;
  final bool isDone4;
  final String docid;
  final String id;

  const MoreViewSubscriptionScheme({
    Key? key,
    required this.isService,
    required this.id,
    required this.uid,
    required this.benefitsList,
    required this.imagesList,
    required this.docid,
    required this.service1Timestamp,
    required this.service2Timestamp,
    required this.service3Timestamp,
    required this.service4Timestamp,
    required this.isDone1,
    required this.isDone2,
    required this.isDone3,
    required this.isDone4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final smallscreenwidth = MediaQuery.of(context).size.width < 280;
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: darkGrey50Color,
          width: 1,
        ),
      ),
      margin: EdgeInsets.only(top: 0, bottom: 10, right: 5, left: 5),
      padding: EdgeInsets.only(top: 10, bottom: 0, right: 5, left: 10),
      child: Column(
        children: [
          ServiceCount(
            serviceName: "1st Service",
            showImage: isDone1,
            date: formatDate(service1Timestamp),
          ),
          SizedBox(height: 10),
          ServiceCount(
            serviceName: "2nd Service",
            showImage: isDone2,
            date: formatDate(service2Timestamp),
          ),
          SizedBox(height: 10),
          ServiceCount(
            serviceName: "3rd Service",
            showImage: isDone3,
            date: formatDate(service3Timestamp),
          ),
          SizedBox(height: 10),
          ServiceCount(
            serviceName: "4th Service",
            showImage: isDone4,
            date: formatDate(service4Timestamp),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(right: 0, top: 10),
            height: 1,
            width: double.infinity,
            child: DottedLine(),
          ),
          FittedBox(
            child: Container(
              margin: EdgeInsets.only(left: 10, top: 20, right: 10),
              child: Row(
                children: [
                  Text(
                    "To discover the advantages of this scheme ",
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: "LexendLight",
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.0),
                              ),
                            ),
                            child: AMCAdvantages(
                              isOnlyAdvantages: true,
                              images: imagesList,
                              title: "",
                              TotalSparesContent: [""],
                              benefits: benefitsList,
                              mrp: 0,
                              TotalSparesMRP: 0,
                              uid: uid,
                              discount: 0,
                              Serviceid: "",
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      "Click Here",
                      style: TextStyle(
                        color: darkBlueColor,
                        fontFamily: "LexendLight",
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          isService
              ? Row(
                  children: [
                    CopyBox(
                      id: id,
                    ),
                    smallscreenwidth ? SizedBox() : ServiceClaim()
                  ],
                )
              : SafeArea(
                  child: CopyBox(
                  id: id,
                )),
          smallscreenwidth ? ServiceClaim() : SizedBox()
        ],
      ),
    );
  }

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMM y').format(dateTime);
  }
}
