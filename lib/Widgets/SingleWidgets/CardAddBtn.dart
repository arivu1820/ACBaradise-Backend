import 'package:acbaradise/Screens/LoadingScreen.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartAddBtn extends StatefulWidget {
  final String productid;
  final String uid;
  final String collectionid;
  final String servicedoc;
  final String servicecoll;

  const CartAddBtn(
      {super.key,
      this.servicedoc = '',
      this.servicecoll = '',
      required this.collectionid,
      required this.productid,
      required this.uid});

  @override
  State<CartAddBtn> createState() => _CartAddBtnState();
}

class _CartAddBtnState extends State<CartAddBtn> {
  bool UseTotalSpares = false;
  bool added = true;
  int count = 0;
  int MRP = 0;
  int discountPercentage = 0;
  int TotalSparesMRP = 0;
  int wet360MRP = 0;
  bool wet360degree = false;

  @override
  void initState() {
    super.initState();
    if (widget.collectionid == 'ProductsCart') {
      checkproductsserviceInCart();
      checkproductMRPInCart();
    } else if (widget.collectionid == 'GeneralProductsCart') {
      checkproductsserviceInCart();
      checkgeneralproductMRPInCart();
    } else if (widget.collectionid == 'ServicesCart') {
      checkproductsserviceInCart();
      checkserviceMRPInCart();
    } else if (widget.collectionid == 'AMCCart') {
      checkamcInCart();
      checkamcMRPInCart();
    }
  }

  Future<void> checkproductMRPInCart() async {
    try {
      QuerySnapshot cartSnapshots =
          await FirebaseFirestore.instance.collection('Categories').get();

      for (QueryDocumentSnapshot categoryDoc in cartSnapshots.docs) {
        DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
            .collection('Categories')
            .doc(categoryDoc.id)
            .collection('Products')
            .doc(widget.productid)
            .get();

        if (productSnapshot.exists) {
          // If the document exists, fetch the count value
          int fetchedMRP = productSnapshot['MRP'] ?? 0;
          int fetchedDiscount = productSnapshot['Discount'] ?? 0;

          // Update the local count and added variable
          setState(() {
            MRP = fetchedMRP;
            discountPercentage = fetchedDiscount;
          });

          // Break out of the loop since we found the product in a category
          break;
        }
      }
    } catch (error) {
      print('Error checking product MRP in cart: $error');
    }
  }

  Future<void> checkgeneralproductMRPInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('GeneralProducts')
          .doc(widget.productid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        int fetchedMRP = cartSnapshot['MRP'] ?? 0;
        int fetchedDiscount = cartSnapshot['Discount'] ?? 0;

        // Update the local count and added variable
        setState(() {
          MRP = fetchedMRP;
          discountPercentage = fetchedDiscount;
        });
      } else {
        print("......................................");
      }
    } catch (error) {
      print('Error checking service in cart: $error');
    }
  }

  Future<void> checkserviceMRPInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Services')
          .doc('hWHRjpawA5D6OTbrjn3h')
          .collection('Categories')
          .doc(widget.servicedoc)
          .collection(widget.servicecoll)
          .doc(widget.productid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        int fetchedMRP = cartSnapshot['MRP'] ?? 0;
        int fetchedDiscount = cartSnapshot['Discount'] ?? 0;

        bool fetchedIs360MRP = (cartSnapshot.data() as Map<String, dynamic>?)
                ?.containsKey('Wash360MRP') ??
            false;

// Retrieve the value if the field exists
        if (fetchedIs360MRP) {
          int fetchedis360MRP = cartSnapshot['Wash360MRP'] ?? 0;
          // Now you can use is360degreeValue in your logic
          setState(() {
            wet360MRP = fetchedis360MRP;
          });
        }

        // Update the local count and added variable
        setState(() {
          MRP = fetchedMRP;
          discountPercentage = fetchedDiscount;
        });
      } else {
        print("......................................");
      }
    } catch (error) {
      print('Error checking service in cart: $error');
    }
  }

  Future<void> checkamcMRPInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Services')
          .doc('hWHRjpawA5D6OTbrjn3h')
          .collection('Categories')
          .doc(widget.servicedoc)
          .collection(widget.servicecoll)
          .doc(widget.productid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        Map<String, dynamic> content = cartSnapshot['Content'] ?? {};
        int fetchedMRP = content['MRP'] ?? 0;
        int fetchedDiscount = content['Discount'] ?? 0;
        int fetchedTotalSparesMRP = content['TotalSparesMRP'] ?? 0;

        // Update the local count and added variable
        setState(() {
          MRP = fetchedMRP;
          discountPercentage = fetchedDiscount;
          TotalSparesMRP = fetchedTotalSparesMRP;
        });
      } else {
        print("......................................");
      }
    } catch (error) {
      print('Error checking service in cart: $error');
    }
  }

  int calculateDiscountedMRP(int totalspares, int wet360) {
    int totalMRP = (MRP + totalspares + wet360) * count;
    double discountedMRP = totalMRP - (totalMRP * discountPercentage / 100);
    return discountedMRP.toInt();
  }

  Future<void> checkproductsserviceInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection(widget.collectionid)
          .doc(widget.productid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        int fetchedCount = cartSnapshot['count'] ?? 0;
        bool fetchedIs360Degree = (cartSnapshot.data() as Map<String, dynamic>?)
                ?.containsKey('is360degree') ??
            false;

// Retrieve the value if the field exists
        if (fetchedIs360Degree) {
          bool is360degreeValue = cartSnapshot['is360degree'];
          // Now you can use is360degreeValue in your logic
          setState(() {
            wet360degree = is360degreeValue;
          });
        }

        // Update the local count and added variable
        setState(() {
          count = fetchedCount;
          added = fetchedCount > 0;
        });
      } else {
        // If the document doesn't exist, set added to false
        setState(() {
          added = false;
        });
      }
    } catch (error) {
      print('Error checking service in cart: $error');
    }
  }

  Future<void> checkamcInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection(widget.collectionid)
          .doc(widget.productid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        int fetchedCount = cartSnapshot['count'] ?? 0;
        bool fetchedUseTotalSpares = cartSnapshot['UseTotalSpares'] ?? false;

        // Update the local count and added variable
        setState(() {
          count = fetchedCount;
          added = fetchedCount > 0;
          UseTotalSpares = fetchedUseTotalSpares;
        });
      } else {
        // If the document doesn't exist, set added to false
        setState(() {
          added = false;
        });
      }
    } catch (error) {
      print('Error checking service in cart: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        added
            ? Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: darkBlue50Color,
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>MyCartScreen(uid: widget.uid)),
                              );

                          try {
                            if (count > 1) {
                              // Decrement the count in Firestore document if count is greater than 1
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.uid)
                                  .collection(widget.collectionid)
                                  .doc(widget.productid)
                                  .update({'count': FieldValue.increment(-1)});

                              // Update the local state
                              setState(() {
                                count = --count;
                              });
                              
                            } else if (count == 1) {
                              // Decrement to 0, remove the document from Firestore
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(widget.uid)
                                  .collection(widget.collectionid)
                                  .doc(widget.productid)
                                  .delete();

                              // Update the local state
                              setState(() {
                                count = --count;
                                added = false;
                              });
                              
                            }
                            
                          } catch (error) {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           MyCartScreen(uid: widget.uid)),
                            // );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Error updating count in Firestore: $error'),
                              ),
                            );
                          }
                          // Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>LoadingScreen()),
                          //     );
                        },
                        icon: Image.asset(
                          "Assets/Icons/Minus.png",
                          height: 12,
                          width: 12,
                        ),
                      ),
                      Text(
                        count.toString(),
                        style: const TextStyle(
                          fontFamily: "lexendRegular",
                          fontSize: 20,
                          color: darkBlueColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>MyCartScreen(uid: widget.uid)),
                              );
                          try {
                            // Increment the count in Firestore document
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(widget.uid)
                                .collection(widget.collectionid)
                                .doc(widget.productid)
                                .update({'count': FieldValue.increment(1)});

                            // Update the local state
                            // setState(() {
                            //   count = ++count;
                            // });
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Error updating count in Firestore: $error'),
                              ),
                            );
                          }
                        },
                        icon: Image.asset(
                          "Assets/Icons/Plus.png",
                          height: 14,
                          width: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: darkBlue50Color,
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          added = true;
                          count = ++count;
                        });
                      },
                      child: Text(
                        "Add",
                        style: const TextStyle(
                          fontFamily: "lexendRegular",
                          fontSize: 20,
                          color: darkBlueColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        Text(
          wet360degree
              ? '₹ ${NumberFormat('#,##,###').format(calculateDiscountedMRP(0, wet360MRP))}  '
              // : '₹ ${NumberFormat('#,##,###').format(calculateDiscountedMRP(0, 0))}  ',
              : UseTotalSpares
                  ? '₹ ${NumberFormat('#,##,###').format(calculateDiscountedMRP(TotalSparesMRP, 0))}  '
                  : '₹ ${NumberFormat('#,##,###').format(calculateDiscountedMRP(0, 0))}  ',
          style: const TextStyle(
            fontFamily: "LexendLight",
            fontSize: 17,
            color: blackColor,
          ),
        ),
      ],
    );
  }
}
