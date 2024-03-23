import 'package:acbaradise/Theme/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyCartBanner extends StatelessWidget {
  final String page;
  MyCartBanner({required this.page});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return page == 'HomePage'
        ? FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('BannerImages')
                .doc('HomePageBanner')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: black5Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: screenWidth * 0.25,
                  child: SizedBox(),
                );
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  !snapshot.data!.exists) {
                // If there's an error, or snapshot doesn't have data, or document doesn't exist, return empty string
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: black5Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: screenWidth * 0.25,
                );
              } else {
                // If document exists, extract the image URL
                final imageUrl = snapshot.data!
                        ['Image'] ??
                    '';
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                  height: screenWidth * 0.25,
                );
              }
            },
          )
        : FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('BannerImages')
                .doc('CartPageBanner')
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: black5Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: screenWidth * 0.25,
                  child: SizedBox(),
                );
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  !snapshot.data!.exists) {
                // If there's an error, or snapshot doesn't have data, or document doesn't exist, return empty string
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    color: black5Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: screenWidth * 0.25,
                );
              } else {
                // If document exists, extract the image URL
                final imageUrl = snapshot.data!
                        ['Image'] ??
                    '';
                return Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                  height: screenWidth * 0.25,
                );
              }
            },
          );
  }
}
