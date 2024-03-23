import 'package:acbaradise/Screens/AnnualContractScreen.dart';
import 'package:acbaradise/Screens/ServiceScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceAndAMCContainer extends StatelessWidget {
  final String uid;
  const ServiceAndAMCContainer({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ServiceScreen(
                          uid: uid,
                        )),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: darkBlue25Color,
                    offset: Offset(0, 0),
                    blurRadius: 4.0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              width: 175,
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 20),
                    child: Text(
                      "Service's",
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: "LexendLight",
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    width: double.infinity,
                    height: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "Assets/Icons/Services_Img.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    // FadeInImage(
                    //     placeholder: AssetImage('Assets/Icons/Google_icon.png'),
                    //     image: NetworkImage(
                    //         "https://lh3.googleusercontent.com/a/ACg8ocKA3JQohpdr3bH6NCwXJwn_xzyP4KcFiCV6qM2uwTn7zQ=s96-c")),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnnualContractScreen(
                          uid: uid,
                        )),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 20, top: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: darkBlue25Color,
                    offset: Offset(0, 0),
                    blurRadius: 4.0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              width: 175,
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 20),
                    child: Text(
                      "AMC",
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: "LexendLight",
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    width: double.infinity,
                    height: 110,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "Assets/Icons/AMC_Img.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
