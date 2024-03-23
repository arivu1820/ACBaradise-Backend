import 'package:acbaradise/Authentication/SigninScreen.dart';
import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Screens/HomeScreen.dart';
import 'package:acbaradise/Screens/SplashScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<String?>(
              future: DatabaseHelper.getUid(),
              builder: (context, uidSnapshot) {
                if (uidSnapshot.hasData) {
                  String currentUserUID = uidSnapshot.data!;
                  return FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance.collection("Users").doc(currentUserUID).get(),
                    builder: (context, documentSnapshot) {
                      if (documentSnapshot.hasError) {
                        print("Error checking document: ${documentSnapshot.error}");
                        // Handle the error and return an appropriate Widget
                        return Text("Error: ${documentSnapshot.error}");
                      } else if (documentSnapshot.connectionState == ConnectionState.waiting) {
                        // If the Future is still waiting for data, return a loading indicator
                        return SplashScreen();
                      } else {
                        
                        // Document exists, navigate to HomeScreen
                        return HomeScreen(uid: currentUserUID);
                      }
                    },
                  );
                } else {
                  // Handle the case where there's no user UID
                  return Text("No UID available");
                }
              },
            );
          } else {
            // Handle the case where there's no user data in snapshot
            // You should return a Widget here as well
            return SigninScreen(uid: DatabaseHelper.getUid().toString(),); // Pass UID to SigninScreen
          }
        },
      ),
    );
  }


}
