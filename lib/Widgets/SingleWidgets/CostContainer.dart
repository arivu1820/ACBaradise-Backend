// import 'package:acbaradise_2024/Theme/Colors.dart';
// import 'package:acbaradise_2024/Widgets/SingleWidgets/ContinueToPaymentBtn.dart';
// import 'package:acbaradise_2024/Widgets/SingleWidgets/SimplyExpand.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';

// class CostContainer extends StatelessWidget {
//   final String uid;

//   CostContainer({Key? key, required this.uid}) : super(key: key);

//   num totalDiscount = 0;

//   @override
//   Widget build(BuildContext context) {
//     // final screenWidth = MediaQuery.of(context).size.width;
//     return Container();

//     // return Column(
//     //   children: [
//     //     Container(
//     //       padding: const EdgeInsets.all(20),
//     //       margin:
//     //           const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 150),
//     //       width: double.infinity,
//     //       decoration: BoxDecoration(
//     //         borderRadius: BorderRadius.circular(5),
//     //         boxShadow: [
//     //           BoxShadow(
//     //             color: darkBlue50Color,
//     //             offset: Offset(0, 0),
//     //             blurRadius: 4.0,
//     //             spreadRadius: 0,
//     //           ),
//     //         ],
//     //         color: whiteColor,
//     //       ),
//     //       child: Column(
//     //         children: [
//     //           StreamBuilder<QuerySnapshot>(
//     //             stream: FirebaseFirestore.instance
//     //                 .collection('Users')
//     //                 .doc(uid)
//     //                 .collection('ProductsCart')
//     //                 .snapshots(),
//     //             builder: (context, snapshot) {
//     //               if (snapshot.hasError) {
//     //                 return Text('Some Problem occur please try after sometime!',textAlign: TextAlign.center,);
//     //               }

//     //               if (snapshot.connectionState == ConnectionState.waiting) {
//     //                 return Container(); // or any other loading indicator
//     //               }

//     //               List<DocumentSnapshot> generalproductWidgets = [];

//     //               for (var product in snapshot.data!.docs) {
//     //                 generalproductWidgets.add(product);
//     //               }


//     //               return FutureBuilder<Map<String, dynamic>>(
//     //                 future: fetchCategoriesDetails(generalproductWidgets),
//     //                 builder: (context, categoriesSnapshot) {
//     //                   if (categoriesSnapshot.connectionState ==
//     //                       ConnectionState.waiting) {
//     //                     return Container(); // or any other loading indicator
//     //                   }

//     //                   // Access the result from the categoriesSnapshot.data
//     //                   Map<String, dynamic> categoriesDetails =
//     //                       categoriesSnapshot.data!;

//     //                   // Access the total price from the fetchCategoriesDetails result
//     //                   num totalPrice = categoriesDetails["totalPrice"] ?? 0;

//     //                   return Column(
//     //                     crossAxisAlignment: CrossAxisAlignment.start,
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     children: [
//     //                       Row(
//     //                         children: [
//     //                           Expanded(
//     //                             child: Text(
//     //                               "Products",
//     //                               style: TextStyle(
//     //                                 fontFamily: "LexendLight",
//     //                                 fontSize: 14,
//     //                                 color: blackColor,
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           const SizedBox(
//     //                               width: 10), // Add spacing between texts
//     //                           Text(
//     //                             '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ', // Set the total price value here
//     //                             style: TextStyle(
//     //                               fontFamily: 'LexendLight',
//     //                               fontSize: 14,
//     //                               color: blackColor,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 10,
//     //                       ),
//     //                     ],
//     //                   );
//     //                 },
//     //               );
//     //             },
//     //           ),

//     //           /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//     //           StreamBuilder<QuerySnapshot>(
//     //             stream: FirebaseFirestore.instance
//     //                 .collection('Users')
//     //                 .doc(uid)
//     //                 .collection('GeneralProductsCart')
//     //                 .snapshots(),
//     //             builder: (context, snapshot) {
//     //               if (snapshot.hasError) {
//     //                 return Container();
//     //               }

//     //               if (snapshot.connectionState == ConnectionState.waiting) {
//     //                 return Container(); // or any other loading indicator
//     //               }

//     //               List<DocumentSnapshot> generalproductWidgets = [];

//     //               for (var product in snapshot.data!.docs) {
//     //                 generalproductWidgets.add(product);
//     //               }


//     //               return FutureBuilder<Map<String, dynamic>>(
//     //                 future: fetchGeneralProductsDetails(generalproductWidgets),
//     //                 builder: (context, categoriesSnapshot) {
//     //                   if (categoriesSnapshot.connectionState ==
//     //                       ConnectionState.waiting) {
//     //                     return Container(); // or any other loading indicator
//     //                   }

//     //                   // Access the result from the categoriesSnapshot.data
//     //                   Map<String, dynamic> categoriesDetails =
//     //                       categoriesSnapshot.data!;

//     //                   // Access the total price from the fetchCategoriesDetails result
//     //                   num totalPrice = categoriesDetails["totalPrice"] ?? 0;

//     //                   return Column(
//     //                     crossAxisAlignment: CrossAxisAlignment.start,
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     children: [
//     //                       Row(
//     //                         children: [
//     //                           Expanded(
//     //                             child: Text(
//     //                               "General",
//     //                               style: TextStyle(
//     //                                 fontFamily: "LexendLight",
//     //                                 fontSize: 14,
//     //                                 color: blackColor,
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           const SizedBox(
//     //                               width: 10), // Add spacing between texts
//     //                           Text(
//     //                             '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ', // Set the total price value here
//     //                             style: TextStyle(
//     //                               fontFamily: 'LexendLight',
//     //                               fontSize: 14,
//     //                               color: blackColor,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 10,
//     //                       ),
//     //                     ],
//     //                   );
//     //                 },
//     //               );
//     //             },
//     //           ),

//     //           /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     //           StreamBuilder<QuerySnapshot>(
//     //             stream: FirebaseFirestore.instance
//     //                 .collection('Users')
//     //                 .doc(uid)
//     //                 .collection('ServicesCart')
//     //                 .snapshots(),
//     //             builder: (context, snapshot) {
//     //               if (snapshot.hasError) {
//     //                 return Container();
//     //               }

//     //               if (snapshot.connectionState == ConnectionState.waiting) {
//     //                 return Container(); // or any other loading indicator
//     //               }

//     //               List<DocumentSnapshot> AMCWidgets = [];

//     //               for (var AMC in snapshot.data!.docs) {
//     //                 AMCWidgets.add(AMC);
//     //               }


//     //               return FutureBuilder<Map<String, dynamic>>(
//     //                 future: fetchserviceCategoriesDetails(AMCWidgets),
//     //                 builder: (context, categoriesSnapshot) {
//     //                   if (categoriesSnapshot.connectionState ==
//     //                       ConnectionState.waiting) {
//     //                     return Container(); // or any other loading indicator
//     //                   }

//     //                   // Access the result from the categoriesSnapshot.data
//     //                   Map<String, dynamic> categoriesDetails =
//     //                       categoriesSnapshot.data!;

//     //                   // Access the total price from the fetchCategoriesDetails result
//     //                   num totalPrice = categoriesDetails["totalPrice"] ?? 0;

//     //                   return Column(
//     //                     crossAxisAlignment: CrossAxisAlignment.start,
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     children: [
//     //                       Row(
//     //                         children: [
//     //                           Expanded(
//     //                             child: Text(
//     //                               "Services",
//     //                               style: TextStyle(
//     //                                 fontFamily: 'LexendLight',
//     //                                 fontSize: 14,
//     //                                 color: blackColor,
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           const SizedBox(
//     //                               width: 10), // Add spacing between texts
//     //                           Text(
//     //                             '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ', // Set the total price value here
//     //                             style: TextStyle(
//     //                               fontFamily: "LexendLight",
//     //                               fontSize: 14,
//     //                               color: blackColor,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 10,
//     //                       ),
//     //                     ],
//     //                   );
//     //                 },
//     //               );
//     //             },
//     //           ),

//     //           /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//     //           StreamBuilder<QuerySnapshot>(
//     //             stream: FirebaseFirestore.instance
//     //                 .collection('Users')
//     //                 .doc(uid)
//     //                 .collection('AMCCart')
//     //                 .snapshots(),
//     //             builder: (context, snapshot) {
//     //               if (snapshot.hasError) {
//     //                 return Container();
//     //               }

//     //               if (snapshot.connectionState == ConnectionState.waiting) {
//     //                 return Container(); // or any other loading indicator
//     //               }

//     //               List<DocumentSnapshot> AMCWidgets = [];

//     //               for (var AMC in snapshot.data!.docs) {
//     //                 AMCWidgets.add(AMC);
//     //               }


//     //               return FutureBuilder<Map<String, dynamic>>(
//     //                 future: fetchamcCategoriesDetails(AMCWidgets),
//     //                 builder: (context, categoriesSnapshot) {
//     //                   if (categoriesSnapshot.connectionState ==
//     //                       ConnectionState.waiting) {
//     //                     return Container(); // or any other loading indicator
//     //                   }

//     //                   // Access the result from the categoriesSnapshot.data
//     //                   Map<String, dynamic> categoriesDetails =
//     //                       categoriesSnapshot.data!;

//     //                   // Access the total price from the fetchCategoriesDetails result
//     //                   num totalPrice = categoriesDetails["totalPrice"] ?? 0;

//     //                   return Column(
//     //                     crossAxisAlignment: CrossAxisAlignment.start,
//     //                     mainAxisSize: MainAxisSize.min,
//     //                     children: [
//     //                       Row(
//     //                         children: [
//     //                           Expanded(
//     //                             child: Text(
//     //                               "AMC",
//     //                               style: TextStyle(
//     //                                 fontFamily: "LexendLight",
//     //                                 fontSize: 14,
//     //                                 color: blackColor,
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           const SizedBox(
//     //                               width: 10), // Add spacing between texts
//     //                           Text(
//     //                             '₹ ${NumberFormat('#,##,##0.00').format(totalPrice)}  ',
//     //                             // Set the total price value here
//     //                             style: TextStyle(
//     //                               fontFamily: 'LexendLight',
//     //                               fontSize: 14,
//     //                               color: blackColor,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                       const SizedBox(
//     //                         height: 10,
//     //                       ),
//     //                     ],
//     //                   );
//     //                 },
//     //               );
//     //             },
//     //           ),
//     //           Row(
//     //             children: [
//     //               Expanded(
//     //                 child: Text(
//     //                   "Discount",
//     //                   style: TextStyle(
//     //                     fontFamily: "LexendLight",
//     //                     fontSize: 14,
//     //                     color: leghtGreen,
//     //                   ),
//     //                 ),
//     //               ),
//     //               const SizedBox(width: 10), // Add spacing between texts
//     //               FutureBuilder<Map<String, dynamic>>(
//     //                 future: getTotalDiscount(),
//     //                 builder: (context, snapshot) {
//     //                   if (snapshot.connectionState == ConnectionState.waiting) {
//     //                     return Container();
//     //                   } else if (snapshot.hasError) {
//     //                     return Text("0");
//     //                   } else {
//     //                     return Text(
//     //                       snapshot.data!['totaldiscount'] > 0.00
//     //                           ? '₹ -${NumberFormat('#,##,##0.00').format(snapshot.data!['totaldiscount'])}  '
//     //                           : '₹ ${NumberFormat('#,##,##0.00').format(snapshot.data!['totaldiscount'])}  ',
//     //                       style: TextStyle(
//     //                         fontFamily: "LexendLight",
//     //                         fontSize: 14,
//     //                         color: leghtGreen,
//     //                       ),
//     //                     );
//     //                   }
//     //                 },
//     //               ),
//     //             ],
//     //           ),
//     //           const SizedBox(
//     //             height: 10,
//     //           ),
//     //           Container(
//     //             height: 1,
//     //             width: screenWidth - 60,
//     //             color: lightGrayColor,
//     //           ),
//     //           const SizedBox(
//     //             height: 10,
//     //           ),
//     //           Row(
//     //             children: [
//     //               Expanded(
//     //                 child: Text(
//     //                   "To Pay",
//     //                   style: TextStyle(
//     //                     fontFamily: "LexendLight",
//     //                     fontSize: 14,
//     //                     color: blackColor,
//     //                   ),
//     //                 ),
//     //               ),
//     //               FutureBuilder<Map<String, dynamic>>(
//     //                 future: getTotalDiscount(),
//     //                 builder: (context, snapshot) {
//     //                   if (snapshot.connectionState == ConnectionState.waiting) {
//     //                     return Container();
//     //                   } else if (snapshot.hasError) {
//     //                     return Text("0");
//     //                   } else {
//     //                     return Text(
//     //                       '₹ ${NumberFormat('#,##,##0.00').format(snapshot.data!['totalprice'])}  ',
//     //                       style: TextStyle(
//     //                         fontFamily: "LexendLight",
//     //                         fontSize: 14,
//     //                         color: blackColor,
//     //                       ),
//     //                     );
//     //                   }
//     //                 },
//     //               ),
//     //             ],
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //     FutureBuilder<Map<String, dynamic>>(
//     //       future: getTotalDiscount(),
//     //       builder: (context, snapshot) {
//     //         if (snapshot.connectionState == ConnectionState.waiting) {
//     //           return Container();
//     //         } else if (snapshot.hasError) {
//     //           return Text("Try after some time");
//     //         } else {
//     //           return ContinueToPayment(
//     //               uid: uid,
//     //               totalprice: snapshot.data!['totalprice'],
//     //               allserviceproductdetails:
//     //                   snapshot.data!['allserviceproduct']);
//     //         }
//     //       },
//     //     ),
//     //   ],
//     // );
//   }

// //   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// //   Future<Map<String, dynamic>> fetchCategoriesDetails(
// //       List<DocumentSnapshot> generalproductWidgets) async {
// //     Map<String, dynamic> categoriesDetails = {};
// //     num totalPrice = 0;
// //     num totaldiscount = 0;
// //     List<Map<String, dynamic>> productDataList = [];

// //     // Iterate over each product document in 'ProductsCart' collection
// //     for (var product in generalproductWidgets) {
// //       String productId = product.id;
// //       int count = product["count"] ?? 0; // Get count value from 'ProductsCart'

// //       // Retrieve all documents from 'Categories' collection
// //       QuerySnapshot categoriesSnapshot =
// //           await FirebaseFirestore.instance.collection('Categories').get();

// //       // Iterate over each category document
// //       for (var categoryDoc in categoriesSnapshot.docs) {
// //         String categoryId = categoryDoc.id;

// //         // Retrieve the product document from 'Products' subcollection
// //         DocumentSnapshot productDoc = await FirebaseFirestore.instance
// //             .collection('Categories')
// //             .doc(categoryId)
// //             .collection('Products')
// //             .doc(productId)
// //             .get();

// //         // Check if the product document exists
// //         if (productDoc.exists) {
// //           // Store the product details in categoriesDetails map
// //           categoriesDetails[productId] = productDoc.data();

// //           productDataList.add({
// //             "productId": productId,
// //             "docId": categoryId,
// //             "productData": productDoc.data(),
// //             'count': count,
// //           });

// //           totaldiscount += (categoriesDetails[productId]['MRP'] ?? 0) * count -
// //               (categoriesDetails[productId]['MRP'] ?? 0) *
// //                   count *
// //                   (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

// //           // Add the Price value considering count and discount
// //           totalPrice += (categoriesDetails[productId]['MRP'] ?? 0) *
// //               count *
// //               (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

// //         }
// //       }
// //     }

// //     // Add the total price to the categoriesDetails map
// //     categoriesDetails["totalPrice"] = totalPrice;
// //     categoriesDetails['totalDiscount'] = totaldiscount;
// //     categoriesDetails["productDataList"] = productDataList;


// //     return categoriesDetails;
// //   }

// //   Future<Map<String, dynamic>> fetchGeneralProductsDetails(
// //       List<DocumentSnapshot> generalproductWidgets) async {
// //     Map<String, dynamic> categoriesDetails = {};
// //     num totalPrice = 0;
// //     num totaldiscount = 0;
// //     List<Map<String, dynamic>> productDataList = [];

// //     // Iterate over each product document in 'ProductsCart' collection
// //     for (var product in generalproductWidgets) {
// //       String productId = product.id;
// //       int count = product["count"] ?? 0; // Get count value from 'ProductsCart'

// //       // Retrieve all documents from 'Categories' collection

// //       // Iterate over each category document

// //       // Retrieve the product document from 'Products' subcollection
// //       DocumentSnapshot productDoc = await FirebaseFirestore.instance
// //           .collection('GeneralProducts')
// //           .doc(productId)
// //           .get();

// //       // Check if the product document exists
// //       if (productDoc.exists) {
// //         // Store the product details in categoriesDetails map
// //         categoriesDetails[productId] = productDoc.data();

// //         productDataList.add({
// //           "productId": productId,
// //           "productData": productDoc.data(),
// //           'count': count,
// //         });

// //         totaldiscount += (categoriesDetails[productId]['MRP'] ?? 0) * count -
// //             (categoriesDetails[productId]['MRP'] ?? 0) *
// //                 count *
// //                 (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

// //         // Add the Price value considering count and discount
// //         totalPrice += (categoriesDetails[productId]['MRP'] ?? 0) *
// //             count *
// //             (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);



        
// //       }
// //     }
// //     // Add the total price to the categoriesDetails map
// //     categoriesDetails["totalPrice"] = totalPrice;
// //     categoriesDetails['totalDiscount'] = totaldiscount;
// //     categoriesDetails["productDataList"] = productDataList;


// //     return categoriesDetails;
// //   }

// //   Future<Map<String, dynamic>> fetchserviceCategoriesDetails(
// //     List<DocumentSnapshot> generalproductWidgets,
// //   ) async {
// //     Map<String, dynamic> categoriesDetails = {};
// //     List<String> docNames = [
// //       '1GeneralService',
// //       '2WetWash',
// //       '3Repair',
// //       '4InstallUninstall'
// //     ];
// //     List<String> subcollectionNames = [
// //       'GeneralService',
// //       'WetWash',
// //       'Repair',
// //       'InstallUninstall'
// //     ];
// //     num totalPrice = 0;
// //     num totaldiscount = 0;
// //     List<Map<String, dynamic>> productDataList = [];

// //     // Iterate over each product document in 'AMCCart' collection
// //     for (var product in generalproductWidgets) {
// //       String productId = product.id;
// //       int count = product["count"] ?? 0; // Get count value from 'AMCCart'

// //       // Iterate over each subcollection name
// //       for (int i = 0; i < subcollectionNames.length; i++) {
// //         String collectionName = subcollectionNames[i];
// //         String docName = docNames[i];

// //         // Retrieve the product document from the specified subcollection
// //         DocumentSnapshot productDoc = await FirebaseFirestore.instance
// //             .collection('Services')
// //             .doc('hWHRjpawA5D6OTbrjn3h')
// //             .collection('Categories')
// //             .doc(docName)
// //             .collection(collectionName)
// //             .doc(productId)
// //             .get();

// //         // Check if the product document exists
// //         if (productDoc.exists) {
// //           // Store the product details in categoriesDetails map
// //           categoriesDetails[productId] = productDoc.data();

// //           productDataList.add({
// //             "productId": productId,
// //             "collectionName": collectionName,
// //             "productData": productDoc.data(),
// //             'count': count,
// //             'is360degree': product['is360degree'] ?? false,
// //           });

// //           // Determine the correct price field based on conditions
// //           num priceField = categoriesDetails[productId]['MRP'] ?? 0;
// //           if (collectionName == 'WetWash' && product['is360degree'] == true) {
// //             totaldiscount += (categoriesDetails[productId]['Wash360MRP'] ?? 0) *
// //                     count -
// //                 (categoriesDetails[productId]['Wash360MRP'] ?? 0) *
// //                     count *
// //                     (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);

// //             // Add both 'Wash360price' and 'Price' if 'is360degree' is true
// //             totalPrice += (categoriesDetails[productId]['Wash360MRP'] ?? 0) *
// //                 count *
// //                 (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
// //             totalPrice += (priceField) *
// //                 count *
// //                 (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
// //           } else {
// //             totaldiscount += (priceField) * count -
// //                 (priceField) *
// //                     count *
// //                     (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
// //             // Add only 'Price' if 'is360degree' is false or for other categories
// //             totalPrice += (priceField) *
// //                 count *
// //                 (1 - (categoriesDetails[productId]['Discount'] ?? 0) / 100);
// //           }

   
// //         }
// //       }
// //     }

// //     // Add the total price to the categoriesDetails map
// //     categoriesDetails["totalPrice"] = totalPrice;
// //     categoriesDetails['totalDiscount'] = totaldiscount;
// //     categoriesDetails["productDataList"] = productDataList;


// //     return categoriesDetails;
// //   }

// //   Future<Map<String, dynamic>> fetchamcCategoriesDetails(
// //       List<DocumentSnapshot> generalproductWidgets) async {
// //     Map<String, dynamic> categoriesDetails = {};
// //     String docName = '5AMC';
// //     String subcollectionName = 'AMC';
// //     num totalPrice = 0;
// //     num totalDiscount = 0;
// //     List<Map<String, dynamic>> productDataList = [];

// //     Future<DocumentSnapshot> getProductDocument(
// //         String docName, String collectionName, String productId) async {
// //       return await FirebaseFirestore.instance
// //           .collection('Services')
// //           .doc('hWHRjpawA5D6OTbrjn3h')
// //           .collection('Categories')
// //           .doc(docName)
// //           .collection(collectionName)
// //           .doc(productId)
// //           .get();
// //     }

// //     for (var product in generalproductWidgets) {
// //       String productId = product.id;
// //       int count = product["count"] ?? 0;

// //       DocumentSnapshot productDoc =
// //           await getProductDocument(docName, subcollectionName, productId);

// //       if (productDoc.exists) {
// //         categoriesDetails[productId] = productDoc.data();

// //         productDataList.add({
// //           "productId": productId,
// //           "collectionName": subcollectionName,
// //           "productData": productDoc.data(),
// //           'count': count,
// //           'title': categoriesDetails[productId]['Content']['Title'],
// //           'UseTotalSpares': product['UseTotalSpares'],
// //         });

// //         String priceField = 'MRP';
// //         num productPrice =
// //             categoriesDetails[productId]['Content'][priceField] ?? 0;
// //         num discount =
// //             (categoriesDetails[productId]['Content']['Discount'] ?? 0) / 100;

// //         if (subcollectionName == 'AMC' && product['UseTotalSpares'] == true) {
// //           totalDiscount +=
// //               (categoriesDetails[productId]['Content']['TotalSparesMRP'] ?? 0) *
// //                   count *
// //                   (1 - discount);
// //           totalPrice +=
// //               (categoriesDetails[productId]['Content']['TotalSparesMRP'] ?? 0) *
// //                   count *
// //                   (1 - discount);
// //           totalPrice += productPrice * count * (1 - discount);
// //         } else {
// //           totalDiscount += productPrice * count * (1 - discount);
// //           totalPrice += productPrice * count * (1 - discount);
// //         }

// //       }
// //     }

// //     categoriesDetails["totalPrice"] = totalPrice;
// //     categoriesDetails['totalDiscount'] = totalDiscount;
// //     categoriesDetails["productDataList"] = productDataList;

// //     return categoriesDetails;
// //   }

// //   Future<Map<String, dynamic>> getTotalDiscount() async {
// //     final Map<String, dynamic> allincart = {};
// //     // Fetch details for Products
// //     List<DocumentSnapshot> productWidgets = await FirebaseFirestore.instance
// //         .collection('Users')
// //         .doc(uid)
// //         .collection('ProductsCart')
// //         .get()
// //         .then((snapshot) => snapshot.docs);

// //     Map<String, dynamic> productDetails =
// //         await fetchCategoriesDetails(productWidgets);
// //     num productTotalDiscount = productDetails["totalDiscount"] ?? 0;
// //     num productTotalprice = productDetails["totalPrice"] ?? 0;
// //     List<Map<String, dynamic>> productDataList =
// //         productDetails["productDataList"];

// // // general product
// //     List<DocumentSnapshot> generalproductWidgets = await FirebaseFirestore
// //         .instance
// //         .collection('Users')
// //         .doc(uid)
// //         .collection('GeneralProductsCart')
// //         .get()
// //         .then((snapshot) => snapshot.docs);

// //     Map<String, dynamic> generalproductDetails =
// //         await fetchGeneralProductsDetails(generalproductWidgets);
// //     num generalproductTotalDiscount =
// //         generalproductDetails["totalDiscount"] ?? 0;
// //     num generalproductTotalprice = generalproductDetails["totalPrice"] ?? 0;
// //     List<Map<String, dynamic>> generalproductDataList =
// //         generalproductDetails["productDataList"];

// //     // Fetch details for Services
// //     List<DocumentSnapshot> serviceWidgets = await FirebaseFirestore.instance
// //         .collection('Users')
// //         .doc(uid)
// //         .collection('ServicesCart')
// //         .get()
// //         .then((snapshot) => snapshot.docs);

// //     Map<String, dynamic> serviceDetails =
// //         await fetchserviceCategoriesDetails(serviceWidgets);
// //     num serviceTotalDiscount = serviceDetails["totalDiscount"] ?? 0;
// //     num serviceTotalprice = serviceDetails["totalPrice"] ?? 0;
// //     List<Map<String, dynamic>> serviceDataList =
// //         serviceDetails["productDataList"];

// //     // Fetch details for Services
// //     List<DocumentSnapshot> AMCWidgets = await FirebaseFirestore.instance
// //         .collection('Users')
// //         .doc(uid)
// //         .collection('AMCCart')
// //         .get()
// //         .then((snapshot) => snapshot.docs);

// //     Map<String, dynamic> amcDetails =
// //         await fetchamcCategoriesDetails(AMCWidgets);
// //     num amcTotalDiscount = amcDetails["totalDiscount"] ?? 0;
// //     num amcTotalprice = amcDetails["totalPrice"] ?? 0;
// //     List<Map<String, dynamic>> amcDataList = amcDetails["productDataList"];

// //     // Sum up the total discounts from different streams
// //     num totalDiscount = productTotalDiscount +
// //         serviceTotalDiscount +
// //         amcTotalDiscount +
// //         generalproductTotalDiscount;
// //     num totalprice = productTotalprice +
// //         serviceTotalprice +
// //         amcTotalprice +
// //         generalproductTotalprice;

// //     allincart['totaldiscount'] = totalDiscount;
// //     allincart['totalprice'] = totalprice;
// //     allincart['allserviceproduct'] = {
// //       'productdatalist': productDataList,
// //       'servicedatalist': serviceDataList,
// //       'amcdatalist': amcDataList,
// //       'generalproductlist': generalproductDataList,
// //     };

// //     return allincart;
// //   }
// }
