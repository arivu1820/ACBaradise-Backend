import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/CartAMCContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AMCInCart extends StatelessWidget {
  final bool isQtyReq;
  final String uid;
  final Map<String, dynamic>? orderdetails;

  const AMCInCart(
      {Key? key, this.orderdetails, required this.isQtyReq, required this.uid})
      : super(key: key);

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
            "AMC",
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
    var products = orderdetails?['AMC'] as Map<String, dynamic>?;

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
        int count = productData['count'] ?? 0;
        num amcorderamount = productData['totalPrice'] ?? 0;

        return CartAMCContainer(
          isQtyReq: isQtyReq,
          title: title,
          uid: uid,
          count: count,
          orderamount: amcorderamount,
        );
      },
    );
  }

  Widget buildProductsFromStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('AMCCart')
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
            String serviceid = products[index].id;

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Services')
                  .doc('hWHRjpawA5D6OTbrjn3h')
                  .collection('Categories')
                  .doc('5AMC')
                  .collection('AMC')
                  .doc(serviceid)
                  .get(),
              builder: (context, productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!productSnapshot.hasData ||
                    productSnapshot.data!.data() == null) {
                  // Remove document from the database
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(uid)
                      .collection('AMCCart')
                      .doc(serviceid)
                      .delete();

                  return Container(); // or some default widget
                }

                Map<String, dynamic> productDetails =
                    productSnapshot.data!.data() as Map<String, dynamic>;

                String title = productDetails['Content']['Title'] ?? '';

                return CartAMCContainer(
                  isQtyReq: isQtyReq,
                  productid: serviceid,
                  title: title,
                  uid: uid,
                );
              },
            );
          },
        );
      },
    );
  }
}
