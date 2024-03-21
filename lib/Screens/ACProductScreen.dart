import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/HomePageProductsList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AutoImageSlider.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ProductContent.dart';
import 'package:acbaradise/Widgets/SingleWidgets/ProductLargeCartBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/OverviewContent.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SpecificationContent.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:intl/intl.dart';

class ACProductScreen extends StatelessWidget {
  final String ProductName;
  final String ProductId;
  final String CategoryId;
    final String uid;


  ACProductScreen({
    required this.ProductName,
    required this.ProductId,
    required this.CategoryId,
    required this.uid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(
        PageName: ProductName,
        iscart: true,
        uid: uid,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: DatabaseHelper.getProductById(CategoryId, ProductId),
        builder: (context, snapshot) {
          // Define an async function to handle the asynchronous logic
          Future<Widget> buildWidget() async {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}' + "Hello....................");
            }

            var product = snapshot.data!; // Assuming you want the first product
            List<dynamic>? images = product['Images'];
            int discount = product['Discount'] ?? 0;
            int mrp = product['MRP'] ?? 0;
            List<dynamic>? overview = product['Overview'];
            Map<dynamic, dynamic>? specifications = product['Specification'];
            int stock = product['Stock'];

            // Use getUid function with await
            String? uid = await DatabaseHelper.getUid();

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: const SizedBox(
                        width: 20,
                      ),
                    ),
                    Text(
                      discount.toString() + "% off",
                      style: TextStyle(
                        fontFamily: "LexendRegular",
                        fontSize: 16,
                        color: brownColor,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                AutoImageSlider(
                  imageurls: images,
                ),
                ProductContent(
                  ProductName: ProductName,
                ),
            
            
                ProductLargeCartBtn(productid: ProductId,title: ProductName,img: images![0],uid: uid??'',stock: stock,),
            
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      children: [
                        Text(
                          '₹ ${NumberFormat('#,##,###').format((mrp - (mrp * discount / 100)))}',
                          style: TextStyle(
                            fontFamily: "LexendRegular",
                            fontSize: 30,
                            color: blackColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'M.R.P ₹ ${NumberFormat('#,##,###').format(mrp)}',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontFamily: "LexendRegular",
                            fontSize: 18,
                            color: black50Color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Text(
                          '(save ₹ ${NumberFormat('#,##,###').format(mrp - (mrp - (mrp * discount / 100)))})',
                    style: TextStyle(
                      fontFamily: "LexendRegular",
                      fontSize: 20,
                      color: darkBlueColor,
                    ),
                  ),
                ),
                OverviewContent(
                  overView: overview,
                ),
                SpecificationContent(specifications: specifications,),
                // HomePageProductsList(ProductName: "Stabilizer"),
                const SizedBox(
                  height: 20,
                ),
                // Add the rest of your widgets here
                ],
              ),
            );
          }

          // Call the async function and handle errors if any
          return FutureBuilder<Widget>(
            future: buildWidget(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return snapshot.data ?? Container(); // Return the widget
              } else {
                return CircularProgressIndicator(); // Show loading indicator until done
              }
            },
          );
        },
      ),
    );
  }
}

