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
  bool isService = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
    fetchCount();
  }

  Future<void> fetchCount() async {
    Map<String, dynamic>? schemeCollection =
        widget.document['SchemeCollection'] as Map<String, dynamic>?;

    if (schemeCollection != null) {
      // Iterate through all scheme IDs
      for (var id in schemeCollection.keys) {
        // Check if 'Avail' is true under each ID
        if (schemeCollection[id]['Avail'] == true) {
          count++;
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String schemeTitle = widget.document['title']; // Adjust the field name
    int qty = widget.document['SchemeCollection']?.length ?? 0;
    // Adjust the field name

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
                    "$count annual service not yet completed",
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

                      // Sort schemeKeys based on timestamps
                      schemeKeys.sort((a, b) {
                        Map<String, dynamic>? schemeDataA =
                            widget.document['SchemeCollection']?[a];
                        Map<String, dynamic>? schemeDataB =
                            widget.document['SchemeCollection']?[b];

                        // Get timestamps from schemeDataA and schemeDataB
                        DateTime timestampA =
                            schemeDataA?['CreatedAt']?.toDate() ?? DateTime(0);
                        DateTime timestampB =
                            schemeDataB?['CreatedAt']?.toDate() ?? DateTime(0);

                        // Compare timestamps for sorting
                        return timestampA.compareTo(
                            timestampB); // Sorting in ascending order
                      });

                      // Get the current key based on the sorted schemeKeys and index
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
                          includeservice: schemeData['SparesIncluded'] ?? false,
                          benefitsList: schemeData['Benefits'] ?? [],
                          imagesList: schemeData['Images'] ?? [],
                          service1Timestamp: schemeData['Service0']
                              ?['Timestamp'],
                          Claimed1: schemeData['Claimed1'] ?? false,
                          Claimed2: schemeData['Claimed2'] ?? false,
                          Claimed3: schemeData['Claimed3'] ?? false,
                          Claimed4: schemeData['Claimed4'] ?? false,
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
                          docid: widget.document.id,
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
