import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/RepairContentContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Repair extends StatelessWidget {
  final String docid;
  final String uid;
  const Repair({super.key,required this.docid,required this.uid});

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<QuerySnapshot>(
      stream: DatabaseHelper.RepairCollection(docid),
      builder: (context, serviceSnapshot) {
        if (serviceSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (serviceSnapshot.hasError) {
          return Text('Error: ${serviceSnapshot.error}');
        }

        var categoryDocuments = serviceSnapshot.data!.docs;

        // Use categoryDocuments to access data from all documents in the Categories subcollection
        List<Widget> generalServiceWidgets = categoryDocuments
            .map((categoryDocument) {
              String image = categoryDocument['Image'];
              int mrp = categoryDocument['MRP'] ?? 0;
                            int discount = categoryDocument['Discount'] ?? 0;

              String title = categoryDocument['Title'] ?? '';
              List<dynamic>? benefits = categoryDocument['Benefits'];
          String serviceid =  categoryDocument.id;

              return RepairContentContainer(
                benefits: benefits,
                Images: image,
                title: title,
                MRP: mrp,
                uid: uid,
                discount:discount,
                serviceid: serviceid,
                category: 'Repair',
              );
            })
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Repair",
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
