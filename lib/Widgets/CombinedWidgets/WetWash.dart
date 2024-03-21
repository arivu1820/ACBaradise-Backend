import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/WetWashContentContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WetWash extends StatelessWidget {
  final String docid;
  final String uid;
  const WetWash({super.key, required this.docid, required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseHelper.WetWashCollection(
          docid), // Assuming WetWashCollection is a method in DatabaseHelper
      builder: (context, wetWashSnapshot) {
        if (wetWashSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (wetWashSnapshot.hasError) {
          return Text('Error: ${wetWashSnapshot.error}');
        }

        var wetWashDocuments = wetWashSnapshot.data!.docs;

        // Use wetWashDocuments to access data from all documents in the WetWash subcollection
        List<Widget> wetWashWidgets = wetWashDocuments.map((wetWashDocument) {
          // Adjust the field names according to your data model
          String image = wetWashDocument['Image'];
          int mrp = wetWashDocument['MRP'] ?? 0;
                    int discount = wetWashDocument['Discount'] ?? 0;

          String title = wetWashDocument['Title'] ?? '';
          List<dynamic>? benefits = wetWashDocument['Benefits'];
          int Wash360MRP = wetWashDocument['Wash360MRP'] ?? 0;
          bool is360 = wetWashDocument['is360'];
          String serviceid = wetWashDocument.id;

          return WetWashContentContainer(
            benefits: benefits,
            Images: image,
            title: title,
            discount: discount,
            mrp: mrp,
            is360degree: is360,
            wash360mrp: Wash360MRP,
            serviceid: serviceid,
            uid: uid,
            category: 'Wet Wash',
          );
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Wet Wash",
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "LexendRegular",
                  color: blackColor,
                ),
              ),
            ),
            // Display all WetWashContentContainer widgets
            ...wetWashWidgets,
          ],
        );
      },
    );
  }
}
