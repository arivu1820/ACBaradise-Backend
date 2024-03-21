import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CommonBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/TextContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressDetailsScreen extends StatelessWidget {
  final String uid;

  final TextEditingController field1Controller = TextEditingController();
  final TextEditingController field2Controller = TextEditingController();
  final TextEditingController field3Controller = TextEditingController();
  final TextEditingController field4Controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AddAddressDetailsScreen({required this.uid});



  static const LatLng sourcelocaion = LatLng(37.00, 52.3);

  @override
  Widget build(BuildContext context) {

      void _submitForm(
    TextEditingController field1Controller,
    TextEditingController field2Controller,
    TextEditingController field3Controller,
    TextEditingController field4Controller,
  ) async {
    if (_formKey.currentState!.validate()) {
      // Your logic here
      Map<String, dynamic> ServiceDetails = {
        'HouseNoFloor': field1Controller.text,
        'BuildingStreet' : field2Controller.text,
        'LandmarkAreaName' : field3Controller.text,
        'Contact' : field4Controller.text,
        'isSelected' : true,
      };

      try {
        
        await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('AddedAddress')
          .get()
          .then((querySnapshot) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          doc.reference.update({'isSelected': false});
        }
      });
      
        await DatabaseHelper.addaddress(
          uid: uid,
          serviceDetails: ServiceDetails,
        );

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Address add successfully'),
                        ),
                      );

        // You can access the text from the controllers like this:

        // Do something with the values if needed.
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Address not added'),
                        ),
                      );
        // Handle error
      }
    } 
  }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(
        PageName: "Add Address Detail",
        iscart: false,
        uid: uid,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              color: lightBlue25Color,
              child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: sourcelocaion, zoom: 14.5),
                  markers: {
                    Marker(
                        markerId: MarkerId("source"), position: sourcelocaion),
                  }),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextContainer(
                    controller: field1Controller,
                    label: "House No. & Floor",
                    limit: 15,
                    isnum: false,
                  ),
                  TextContainer(
                    controller: field2Controller,
                    label: "Building & Street",
                    limit: 50,
                    isnum: false,
                    minCharacters: 5,
                  ),
                  TextContainer(
                    controller: field3Controller,
                    label: "Landmark & Area Name (Optional)",
                    isOptional: true,
                    limit: 50,
                    isnum: false,
                    minCharacters: 0,
                  ),
                  TextContainer(
                    controller: field4Controller,
                    label: "Contact No.",
                    limit: 10,
                    isnum: true,
                    minCharacters: 10,
                  ),
                  CommonBtn(
  BtnName: "Save Address",
  function: () => _submitForm(field1Controller, field2Controller, field3Controller, field4Controller),
  isSelected: true,
),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
