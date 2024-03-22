import 'package:acbaradise/Authentication/SigninScreen.dart';
import 'package:acbaradise/Screens/AnnualContractScreen.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Screens/OrdersScreen.dart';
import 'package:acbaradise/Screens/SubscriptionScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/DrawerChildContioner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DrawerWidget extends StatelessWidget {
  final String uid;

  DrawerWidget({required this.uid});
  Future<Map<String, dynamic>> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      return userDoc.data() ?? {};
    } catch (e) {
      print("Error fetching user data from Firestore: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading indicator while data is being fetched
        }

        String name = snapshot.data?['name'] ?? '';
        String email = snapshot.data?['email'] ?? '';
        String ImageUrl = snapshot.data?['profileImageUrl'] ?? '';

        return Drawer(
          // Rest of your existing code...
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: lightBlue50Color,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: whiteColor,
                          ),
                          child: ClipOval(
                            child: Image.network(
                              ImageUrl,
                              height: 50,
                              width: 50,
                              fit: BoxFit
                                  .cover, // Adjust the BoxFit property as needed
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontFamily: "LexendRegular",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  color: blackColor,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                email,
                                style: const TextStyle(
                                  fontFamily: "LexendRegular",
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersScreen(uid: uid,),
                      ),
                    );
                  },
                  child: DrawerChildContioner(
                      name: "Orders", image: "Assets/Icons/Orders_Icon.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCartScreen(uid: uid,),
                      ),
                    );
                  },
                  child: DrawerChildContioner(
                      name: "My Cart", image: "Assets/Icons/My_Cart_Icon.png"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubscriptionScreen(uid: uid,),
                      ),
                    );
                  },
                  child: DrawerChildContioner(
                      name: "Annual Contract Subscription",
                      image: "Assets/Icons/AMC_Icon.png"),
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SigninScreen(uid: uid,);
                      }));
                    } on FirebaseAuthException catch (e) {
                      throw e.message!;
                    } catch (e) {
                      throw "Unable to logout, Try again";
                    }
                  },
                  child: DrawerChildContioner(
                      name: "About Us", image: "Assets/Icons/AboutUs_Icon.png"),
                ),
                DrawerChildContioner(
                    name: "Support", image: "Assets/Icons/Call_Icon.png"),
              ],
            ),
          ),
        );
      },
    );
  }
}
