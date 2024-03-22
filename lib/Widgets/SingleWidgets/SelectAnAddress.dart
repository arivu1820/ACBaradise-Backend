import 'package:acbaradise/Screens/SelectAddressScreen.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectAnAddress extends StatefulWidget {
  final String uid;

  const SelectAnAddress({Key? key, required this.uid}) : super(key: key);

  @override
  State<SelectAnAddress> createState() => _SelectAnAddressState();
}

class _SelectAnAddressState extends State<SelectAnAddress> {
    List<String> availablePinCodes = [];

  @override
  void initState() {
    super.initState();
    // Retrieve available pin codes from Firestore
    FirebaseFirestore.instance
        .collection('AvailableArea')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        availablePinCodes.add(doc['pincode']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select an Address",
            style: const TextStyle(
              fontFamily: "LexendMedium",
              fontSize: 18,
              color: blackColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: darkBlue50Color,
                  offset: Offset(0, 0),
                  blurRadius: 4.0,
                  spreadRadius: 0,
                ),
              ],
              color: whiteColor,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(widget.uid)
                  .collection('AddedAddress')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                bool isSelectedPresent = documents.any(
                    (document) => document['isSelected'] == true);

                String addressText = isSelectedPresent
                    ? documents.firstWhere(
                        (document) => document['isSelected'] == true)['HouseNoFloor'] +
                            ", " +
                            documents.firstWhere(
                                (document) => document['isSelected'] == true)['BuildingStreet'] +
                            " " +
                            documents.firstWhere(
                                (document) => document['isSelected'] == true)['LandmarkAreaName']
                    : "Select your address";

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "Assets/Icons/mapPoint.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        addressText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "LexendLight",
                          fontSize: 14,
                          color: blackColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectAddressScreen(uid: widget.uid,availablePinCodes: availablePinCodes,),
                          ),
                        );
                      },
                      child: Text(
                        "Select" ,
                        style: const TextStyle(
                          fontFamily: "LexendMedium",
                          fontSize: 14,
                          color: darkBlueColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
