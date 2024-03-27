import 'package:acbaradise/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSigninBtn extends StatelessWidget {
  final String uid;
  const GoogleSigninBtn({Key? key, required this.uid});

  Future<void> saveUserDataToFirestore(User user) async {
    try {
      // Reference to the Firestore collection 'Users'
      final userCollection = FirebaseFirestore.instance.collection('Users');

      // Create a new document with the user's UID
      await userCollection.doc(user.uid).set({
        'email': user.email,
        'name': user.displayName,
        'profileImageUrl': user.photoURL,
        // You can add more fields as needed
      });
    } catch (e) {
      print("Error saving user data to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(
                  color: darkBlueColor,
                  strokeWidth: 2,
                ),
              );
            });
        try {
          final GoogleSignInAccount? gUser = await GoogleSignIn(
            clientId:
                '813682247245-1bvladq1ic1qhf2oc6g81pk898o6v551.apps.googleusercontent.com',
          ).signIn();

          Navigator.of(context).pop();

          final GoogleSignInAuthentication gAuth = await gUser!.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken,
          );

          // Sign in with Firebase
          UserCredential authResult =
              await FirebaseAuth.instance.signInWithCredential(credential);
          User? user = authResult.user;

          // Save user data to Firestore
          if (user != null) {
            await saveUserDataToFirestore(user);
          }

          // Navigate to the next page on successful sign-in
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                uid: uid,
              ),
            ),
          );
        } catch (e) {
          Navigator.of(context).pop();

          print("Error signing in with Google: $e");
        }
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeScreen()),
        // );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: lightBlueColor,
          borderRadius: BorderRadius.circular(5),
        ),
        height: 60,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "Assets/Icons/Google_icon.png",
              height: 30,
              width: 30,
            ),
            const SizedBox(
              width: 25,
            ),
            const Text(
              "Continue with Google",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "LexendMedium",
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
