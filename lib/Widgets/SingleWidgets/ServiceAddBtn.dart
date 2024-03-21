import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ServiceAddBtn extends StatefulWidget {
  final String uid;
  final String serviceid;
  final String title;
  final bool is360degree;
  final String category;
  ServiceAddBtn(
      {super.key,
      required this.uid,
      required this.serviceid,
      required this.title, this.is360degree = false,required this.category});

  @override
  State<ServiceAddBtn> createState() => _ServiceAddBtnState();
}

class _ServiceAddBtnState extends State<ServiceAddBtn> {
  bool added = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    checkserviceInCart();
  }

  Future<void> checkserviceInCart() async {
    try {
      DocumentSnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection('ServicesCart')
          .doc(widget.serviceid)
          .get();

      if (cartSnapshot.exists) {
        // If the document exists, fetch the count value
        int fetchedCount = cartSnapshot['count'] ?? 0;

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

  @override
  Widget build(BuildContext context) {
    return added
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
                      try {
                        if (count > 1) {
                          // Decrement the count in Firestore document if count is greater than 1
                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('ServicesCart')
                              .doc(widget.serviceid)
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
                              .collection('ServicesCart')
                              .doc(widget.serviceid)
                              .delete();

                          // Update the local state
                          setState(() {
                            count = --count;
                            added = false;
                          });
                        }
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
                      try {
                        // Increment the count in Firestore document
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.uid)
                            .collection('ServicesCart')
                            .doc(widget.serviceid)
                            .update({'count': FieldValue.increment(1)});

                        // Update the local state
                        setState(() {
                          count = ++count;
                        });
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
                  onTap: () async {
                    String uid = widget.uid;
                    Map<String, dynamic> ServiceDetails = {
                      
                      'count': 1,
                      'is360degree':widget.is360degree,
                      
                    };

                    try {
                      await DatabaseHelper.addToServiceCart(
                        uid: uid,
                        serviceId: widget.serviceid,
                        serviceDetails: ServiceDetails,
                      );

                      checkserviceInCart();
                      setState(() {
                        added = true;
                        // count = ++count;
                      });
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding to cart: $error'),
                        ),
                      );
                    }
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
          );
  }
}
