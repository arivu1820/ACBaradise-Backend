import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/MoreViewSubscriptionScheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubscriptionScheme extends StatefulWidget {
  final String uid;
  final QueryDocumentSnapshot<Object?> document;

  const SubscriptionScheme(
      {Key? key, required this.uid, required this.document})
      : super(key: key);

  @override
  _SubscriptionSchemeState createState() => _SubscriptionSchemeState();
}

class _SubscriptionSchemeState extends State<SubscriptionScheme> {
  bool _isExpanded = false;
  bool _isClaim = true;
  bool isService = true;

  @override
  Widget build(BuildContext context) {
    String schemeTitle = widget.document['title']; // Adjust the field name
    int qty = widget.document['SchemeCollection']?.length ??
        0; // Adjust the field name

    return IntrinsicHeight(
      child: AnimatedContainer(
        duration: Duration(seconds: 0),
        width: double.infinity,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
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
                    height: 25,
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      schemeTitle, // Display the scheme title
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "LexendLight",
                        fontSize: 18,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                  width: 50,
                ),
                Text(
                  "Qty: $qty", // Display the quantity
                  style: TextStyle(
                    fontFamily: "LexendLight",
                    fontSize: 14,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "1 annual service not yet completed",
                    style: TextStyle(
                      color: leghtGreen,
                      fontFamily: "LexendLight",
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: Container(
                    width: 20,
                    height: 10,
                    child: Image.asset(
                      _isExpanded
                          ? "Assets/Icons/2_Arrow.png"
                          : "Assets/Icons/Arrow_2.png",
                    ),
                  ),
                ),
              ],
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: List.generate(
                    qty,
                    (index) {
                      // Get all keys (UUIDs) from the SchemeCollection
                      List<String> schemeKeys =
                          widget.document['SchemeCollection']?.keys.toList() ??
                              [];

                      // Get the current key based on the index
                      String currentKey =
                          schemeKeys.length > index ? schemeKeys[index] : '';

                      // Get the schemeData based on the current key
                      Map<String, dynamic>? schemeData =
                          widget.document['SchemeCollection']?[currentKey]
                              as Map<String, dynamic>?;

                      if (schemeData != null) {
                        return MoreViewSubscriptionScheme(
                          isService: true,
                          uid: widget.uid,
                          id: currentKey,
                          benefitsList: schemeData['Benefits'] ?? [],
                          imagesList: schemeData['Images'] ?? [],
                          service1Timestamp: schemeData['Service0']
                              ?['Timestamp'],
                          service2Timestamp: schemeData['Service4']
                              ?['Timestamp'],
                          service3Timestamp: schemeData['Service8']
                              ?['Timestamp'],
                          service4Timestamp: schemeData['Service12']
                              ?['Timestamp'],
                          isDone1: schemeData['Service0']?['IsDone'],
                          isDone2: schemeData['Service4']?['IsDone'],
                          isDone3: schemeData['Service8']?['IsDone'],
                          isDone4: schemeData['Service12']?['IsDone'],
                          docid: currentKey,
                        );
                      } else {
                        // Handle the case where schemeData is null or missing keys
                        return Container(); // or any other widget as a placeholder
                      }
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
