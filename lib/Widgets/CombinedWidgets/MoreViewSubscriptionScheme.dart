import 'dart:async';

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
  final bool includeservice;

  final Timestamp service1Timestamp;
  final Timestamp service2Timestamp;
  final Timestamp service3Timestamp;
  final Timestamp service4Timestamp;
  final bool isDone1;
  final bool isDone2;
  final bool isDone3;
  final bool isDone4;
  final bool Claimed1;
  final bool Claimed2;
  final bool Claimed3;
  final bool Claimed4;
  final String docid;
  final String id;

  MoreViewSubscriptionScheme({
    Key? key,
    required this.isService,
    required this.id,
    this.includeservice = false,
    required this.uid,
    required this.benefitsList,
    required this.imagesList,
    required this.docid,
    required this.service1Timestamp,
    required this.service2Timestamp,
    required this.service3Timestamp,
    required this.service4Timestamp,
    required this.Claimed1,
    required this.Claimed2,
    required this.Claimed3,
    required this.Claimed4,
    required this.isDone1,
    required this.isDone2,
    required this.isDone3,
    required this.isDone4,
  }) : super(key: key);

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final smallscreenwidth = MediaQuery.of(context).size.width < 280;
    bool showServiceClaim = false;

    // Check if any of the service timestamps fall within the current month
    if ((service1Timestamp.toDate().month == now.month &&
            service1Timestamp.toDate().year == now.year &&
            !Claimed1) ||
        (service2Timestamp.toDate().month == now.month &&
            service2Timestamp.toDate().year == now.year &&
            !Claimed2) ||
        (service3Timestamp.toDate().month == now.month &&
            service3Timestamp.toDate().year == now.year &&
            !Claimed3) ||
        (service4Timestamp.toDate().month == now.month &&
            service4Timestamp.toDate().year == now.year &&
            !Claimed4)) {
      showServiceClaim = true;
    }

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
                              includeservice: includeservice,
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
          Row(
            children: [
              CopyBox(
                id: id,
              ),
              smallscreenwidth
                  ? SizedBox()
                  : showServiceClaim
                      ? ServiceClaim(
                          checkfunction: () => checkfunction(context),
                        )
                      : SizedBox(),
              smallscreenwidth
                  ? showServiceClaim
                      ? ServiceClaim(
                          checkfunction: () => checkfunction(context),
                        )
                      : SizedBox()
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }

  void checkfunction(BuildContext context) {
    if (service1Timestamp.toDate().month == now.month) {
      // Update Service1 timestamp
      updateServiceTimestamp(docid, 'Service0');
      showServiceClaimDialog(context); // Call the dialog function here
    } else if (service2Timestamp.toDate().month == now.month) {
      // Update Service2 timestamp
      updateServiceTimestamp(docid, 'Service4');
    } else if (service3Timestamp.toDate().month == now.month) {
      // Update Service3 timestamp
      updateServiceTimestamp(docid, 'Service8');
    } else if (service4Timestamp.toDate().month == now.month) {
      // Update Service4 timestamp
      updateServiceTimestamp(docid, 'Service12');
    }
  }

  void showServiceClaimDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: leghtGreen,
          content: SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
              ),
            ),
          ),
        );
      },
    );

    // Delay for 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close the loading dialog
      showContentDialog(context); // Show the content dialog
    });
  }

  void showContentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: leghtGreen,
          title: Text(
            "Service Claim",
            style: TextStyle(
              fontFamily: 'LexendRegular',
              color: whiteColor,
              fontSize: 18,
            ),
          ),
          content: Text(
            "Your service has been claimed. We will contact you soon. For more detail contact help line. ",
            style: TextStyle(
              fontFamily: 'LexendRegular',
              color: whiteColor,
              fontSize: 14,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "OK",
                style: TextStyle(
                  fontFamily: 'LexendRegular',
                  color: whiteColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to update the service timestamp in Firestore
  Future<void> updateServiceTimestamp(String docId, String serviceField) async {
    try {
      // Update the corresponding service timestamp in Firestore
      await FirebaseFirestore.instance
          .collection('CurrentAMCSubscription')
          .doc(id)
          .set({
        serviceField: {'Timestamp': Timestamp.now()},
        'Claimed': true, // Set Claimed to true outside the serviceField
      }, SetOptions(merge: true));
      print(docId);

      // Update claimed status under Users -> uid -> AMC Subscription
      // Determine the claimed status field based on the serviceField parameter
      String claimedField;
      switch (serviceField) {
        case 'Service0':
          claimedField = 'Claimed1';
          break;
        case 'Service4':
          claimedField = 'Claimed2';
          break;
        case 'Service8':
          claimedField = 'Claimed3';
          break;
        case 'Service12':
          claimedField = 'Claimed4';
          break;
        default:
          claimedField = ''; // Handle other cases if needed
      }

      // Update claimed status under Users -> uid -> AMC Subscription
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('AMC Subscription')
          .doc(docId)
          .set({
        'SchemeCollection': {
          id: {claimedField: true}
        }
      }, SetOptions(merge: true));

      // showAboutDialog(context: context);
    } catch (e) {
      print('Error updating service timestamp: $e');
      // Handle error as needed
    }
  }

  String formatDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('MMM y').format(dateTime);
  }
}
