import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/InstallUninstallContentContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InstallUninstall extends StatelessWidget {
  final String docid;
  final String uid;

  const InstallUninstall({super.key, required this.docid, required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseHelper.InstallUninstallCollection(
          docid), // Assuming InstallUninstallCollection is a method in DatabaseHelper
      builder: (context, installUninstallSnapshot) {
        if (installUninstallSnapshot.connectionState ==
            ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (installUninstallSnapshot.hasError) {
          return Text('Error: ${installUninstallSnapshot.error}');
        }

        var installUninstallDocuments = installUninstallSnapshot.data!.docs;

        // Use installUninstallDocuments to access data from all documents in the InstallUninstall subcollection
        List<Widget> installUninstallWidgets =
            installUninstallDocuments.map((installUninstallDocument) {
          // Adjust the field names according to your data model
          String image = installUninstallDocument['Image'];
          int discount = installUninstallDocument['Discount'] ?? 0;
          int mrp = installUninstallDocument['MRP'] ?? 0;
          String title = installUninstallDocument['Title'] ?? '';
          List<dynamic>? benefits = installUninstallDocument['Benefits'];
          String serviceid = installUninstallDocument.id;

          return InstallUninstallContentContainer(
            benefits: benefits,
            Images: image,
            title: title,
            discount: discount,
            MRP: mrp,
            serviceid: serviceid,
            uid: uid,
            category: 'Install Uninstall',
          );
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Install Uninstall",
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "LexendRegular",
                  color: blackColor,
                ),
              ),
            ),
            // Display all InstallUninstallContentContainer widgets
            ...installUninstallWidgets,
          ],
        );
      },
    );
  }
}
