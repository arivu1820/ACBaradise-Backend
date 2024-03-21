import 'package:acbaradise/Widgets/CombinedWidgets/CartGeneralProductContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/CartProductContainer.dart';
import 'package:acbaradise/Theme/Colors.dart';


class GeneralProductsInCart extends StatelessWidget {
  final bool isQtyReq;
  final String uid;
  final Map<String, dynamic>? orderdetails;

  GeneralProductsInCart({
    Key? key,
    required this.isQtyReq,
    required this.uid,
    this.orderdetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "General Products",
            style: const TextStyle(
              fontFamily: "Stylish",
              fontSize: 18,
              color: darkBlueColor,
            ),
          ),
          isQtyReq
              ? buildProductsFromListview()
              : buildProductsFromStream(),
        ],
      ),
    );
  }

Widget buildProductsFromListview() {
  var products = orderdetails?['GeneralProducts'] as Map<String, dynamic>?;

  if (products == null) {
    // Handle the case where 'Products' is null or not a Map
    return Container();
  }

  var productIds = products.keys.toList();

  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: productIds.length,
    itemBuilder: (context, index) {
      var productId = productIds[index];
      var productData = products[productId] as Map<String, dynamic>;

      if (productData == null) {
        // Handle the case where productData is null
        return Container();
      }

      String title = productData['title'] ?? '';
      String img = productData['img'] ?? '';
      int count = productData['count'] ?? 0;
      num productsorderamount = productData['totalPrice'] ?? 0;

      return CartGeneralProductContainer(
        isQtyReq: isQtyReq,
        count: count,
        title: title,
        uid: uid,
        img: img,
        productsorderamount: productsorderamount,
      );
    },
  );
}

    Widget buildProductsFromStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('GeneralProductsCart')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        var products = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            var productData = products[index].data() as Map<String, dynamic>;
            String productid = products[index].id;

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection(
                      'GeneralProducts')
                  .doc(productid)
                  .get(),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (productSnapshot.hasError ||
                    productSnapshot.data == null ||
                    !productSnapshot.data!.exists) {
                  // Remove product from 'Users' collection
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection('GeneralProductsCart')
                      .doc(productid)
                      .delete();
                  return Container(); // or some default widget
                }

                Map<String, dynamic> productDetails =
                    productSnapshot.data!.data() as Map<String, dynamic>;

                // Extract relevant data from productDetails
                String title = productDetails['Name'] ?? '';
                String img = productDetails['Image'] ?? [];
                int count = productData['count'];

                return CartGeneralProductContainer(
                  isQtyReq: isQtyReq,
                  count: count,
                  productid: productid,
                  title: title,
                  uid: uid,
                  img: img,
                );
              },
            );
          },
        );
      },
    );
  }
}
