import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/GeneralServiceContentContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneralService extends StatelessWidget {
  final String docid;
  final String uid;
  GeneralService({super.key, required this.docid, required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseHelper.GeneralServiceCollection(docid),
      builder: (context, serviceSnapshot) {
        if (serviceSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (serviceSnapshot.hasError) {
          return Text('Error: ${serviceSnapshot.error}');
        }

        var categoryDocuments = serviceSnapshot.data!.docs;

        // Use categoryDocuments to access data from all documents in the Categories subcollection
        List<Widget> generalServiceWidgets =
            categoryDocuments.map((categoryDocument) {
          String image = categoryDocument['Image'];
          int mrp = categoryDocument['MRP'] ?? 0;
          int discount = categoryDocument['Discount'] ?? 0;

          String title = categoryDocument['Title'] ?? '';
          List<dynamic>? benefits = categoryDocument['Benefits'];
          String serviceid = categoryDocument.id;

          return GeneralServiceContentContainer(
            Benefits: benefits,
            Images: image,
            Title: title,
            MRP: mrp,
            discount: discount,
            serviceid: serviceid,
            uid: uid,
            category: 'General Service',
          );
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "General Service",
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "LexendRegular",
                  color: blackColor,
                ),
              ),
            ),
            // Display all GeneralServiceContentContainer widgets
            ...generalServiceWidgets,
          ],
        );
      },
    );
  }
}
