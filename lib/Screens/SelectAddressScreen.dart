import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acbaradise/Screens/AddAddressDetailsScreen.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AddressContainer.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CommonBtn.dart';
import 'package:acbaradise/Theme/Colors.dart';

class SelectAddressScreen extends StatefulWidget {
  final String uid;
  final List<String> availablePinCodes;

  SelectAddressScreen({Key? key, required this.uid,required this.availablePinCodes}) : super(key: key);

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(PageName: "Select Address", iscart: false, uid: widget.uid),
      body: Column(
        children: [
          Expanded(
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

                if (documents.isEmpty) {
                  return Center(
                    child: Text('Add your new address',style: TextStyle(fontFamily: 'LexendRegular',fontSize: 16,color: blackColor),),
                  );
                }

                // Check and delete addresses with invalid pin codes
                documents.forEach((document) {
                  String pincode = document['Pincode'] ?? '';
                  if (!widget.availablePinCodes.contains(pincode)) {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(widget.uid)
                        .collection('AddedAddress')
                        .doc(document.id)
                        .delete();
                  }
                });

                return ListView.builder(
                  itemBuilder: (context, index) {
                    var document = documents[index];

                    String houseNoFloor = document['HouseNoFloor'] ?? '';
                    String buildingStreet = document['BuildingStreet'] ?? '';
                    String landmarkAreaName = document['LandmarkAreaName'] ?? '';
                    String pincode = document['Pincode'] ?? '';
                    String contact = document['Contact'] ?? '';
                    bool isSelected = document['isSelected'] ?? false;

                    return GestureDetector(
                      onTap: () {
                        // Update isSelected for all documents in Firestore
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.uid)
                            .collection('AddedAddress')
                            .get()
                            .then((querySnapshot) {
                          for (QueryDocumentSnapshot doc in querySnapshot.docs) {
                            doc.reference.update({'isSelected': false});
                          }

                          // Set isSelected to true for the tapped document
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('AddedAddress')
                              .doc(document.id)
                              .update({'isSelected': true});
                        });

                        Navigator.of(context).pop();
                      },
                      child: AddressContainer(
                        Address: '$houseNoFloor, $buildingStreet $landmarkAreaName  $pincode.',
                        Contact: contact,
                        isSelected: isSelected,
                        onDelete: () {
                          FirebaseFirestore.instance
                              .collection('Users')
                              .doc(widget.uid)
                              .collection('AddedAddress')
                              .doc(document.id)
                              .delete();
                          // Handle onDelete
                        },
                      ),
                    );
                  },
                  itemCount: documents.length,
                );
              },
            ),
          ),
          CommonBtn(
            BtnName: "Add New Address",
            function: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAddressDetailsScreen(uid: widget.uid, availablePinCodes:widget.availablePinCodes),
                ),
              );
            },
            isSelected: true,
          ),
        ],
      ),
    );
  }
}
