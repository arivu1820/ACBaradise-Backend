import 'package:acbaradise/Screens/ACProductScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/CommonProductsListContainer.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/ProductsListContainer.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ContentFilerContioner.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ManualImageSlider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommonProductScreen extends StatefulWidget {
  final String ProductName;
  final String uid;
  CommonProductScreen({required this.ProductName, required this.uid});

  @override
  State<CommonProductScreen> createState() => _CommonProductScreen();
}

class _CommonProductScreen extends State<CommonProductScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(
          PageName: widget.ProductName, uid: widget.uid, iscart: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: const SizedBox(
                  width: 20,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('GeneralProducts')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or a loading indicator
                }
        
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Container(); // Return an empty container if there's no data
                }
        
                List<DocumentSnapshot> documents = snapshot.data!.docs;
        
                return ListView.builder(
                       shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = documents[index];
                    String productName =
                        document['Name']; // Replace with your field name
                    String imageUrl = document['Image'];
                    int discount = document['Discount'];
                    int mrp = document['MRP'];
                    int stock = document['Stock']; // Replace with your field name
                    return CommonProductsListContainer(
                        stock: stock,
                        imageUrl: imageUrl,
                        mrp: mrp,
                        productName: productName,
                        productid: document.id,
                        uid: widget.uid,
                        discount: discount);
                  },
                  itemCount: documents.length,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
