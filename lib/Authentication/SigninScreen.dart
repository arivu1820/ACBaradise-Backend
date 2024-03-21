import 'package:flutter/material.dart';
import 'package:acbaradise/Widgets/SingleWidgets/GoogleSigninBtn.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SimplyExpand.dart';
import 'package:acbaradise/Widgets/SingleWidgets/TCandPrivacy.dart';
import 'package:flutter/widgets.dart';

class SigninScreen extends StatelessWidget {
  final String uid;
  const SigninScreen({super.key,required this.uid});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const  SimplyExpand(),
          const Text(
            "AC Baradise",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 48,
              fontFamily: "Iceberg",
              color: lightBlueColor,
            ),
          ),
          const SimplyExpand(),
          FittedBox(fit: BoxFit.contain, child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TCandPrivacy(uid: uid,),
          )),
         const SizedBox(
            height: 20,
          ),
          GoogleSigninBtn(uid: uid,),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
