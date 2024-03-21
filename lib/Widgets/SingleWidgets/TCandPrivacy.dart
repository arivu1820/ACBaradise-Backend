import 'package:acbaradise/Screens/PrivacyPolicyScreen.dart';
import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/gestures.dart';

class TCandPrivacy extends StatelessWidget {
  final String uid;
  const TCandPrivacy({Key? key,required this.uid});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontFamily: "LexendMedium",
              fontSize: 12,
              color: blackColor,
            ),
            children: [
              const TextSpan(
                text: "By continuing, you accept",
              ),
              TextSpan(
                text: " T&C",
                style: const TextStyle(
                  color: darkBlueColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(uid: uid,),
                      ),
                    );
                  },
              ),
              const TextSpan(
                text: " and",
              ),
              TextSpan(
                text: " Privacy Policy",
                style: const TextStyle(
                  color: darkBlueColor,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen(uid: uid,),
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
