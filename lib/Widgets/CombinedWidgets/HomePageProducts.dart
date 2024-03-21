import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/HomePageProductsList.dart';
import 'package:acbaradise/Models/DataBaseHelper.dart';

class HomePageProducts extends StatelessWidget {
  final String uid;
  const HomePageProducts({Key? key,required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DatabaseHelper.getCategoryStream(),
      builder: (context, categorySnapshot) {
        if (categorySnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (categorySnapshot.hasError) {
          return Text('Error: ${categorySnapshot.error}');
        }

        List<Widget> productsList = DatabaseHelper.buildProductsList(uid,categorySnapshot.data!.docs);

        return Column(
          children: productsList,
        );
      },
    );
  }
}
