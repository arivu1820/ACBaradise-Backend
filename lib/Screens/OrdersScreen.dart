import 'package:acbaradise/Screens/OrdersProductScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ACPContainer.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final String uid;

  OrdersScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWithCart(PageName: "Orders", iscart: true, uid: uid),
      backgroundColor: whiteColor,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .collection('Orders')
            .orderBy('CreatedAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: darkBlueColor,strokeWidth: 2,));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              Timestamp CreatedAt = orderData["CreatedAt"];
              String OrderId = snapshot.data!.docs[index].id;
              num TotalPrice = orderData['totalamount'];
              String name = orderData['name'];
              String contact = orderData['contact'];
              String address = orderData['address'];
              String orderTitle = orderData['orderTitle'] ?? '';
              DateTime dateTime = CreatedAt.toDate();
              List orderdetails = orderData['OrderDetails'];

              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersProductScreen(
                          uid: uid,
                          address: address,
                          contact: contact,
                          name: name,
                          orderdetails: orderdetails,
                          totalamount: TotalPrice,
                        ),
                      ),
                    );
                  },
                  child: ACPContainer(
                      ifTrue: true,
                      CreatedAt: dateTime,
                      OrderTitle: orderTitle,
                      OrderId: OrderId,
                      TotalPrice: TotalPrice));
            },
          );
        },
      ),
    );
  }
}
