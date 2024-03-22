import 'package:acbaradise/Models/DataBaseHelper.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart' as ggg;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CommonBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/TextContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressDetailsScreen extends StatefulWidget {
  final String uid;
  final List<String> availablePinCodes;

  AddAddressDetailsScreen({required this.uid, required this.availablePinCodes});

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(12.979795, 80.218301), zoom: 18);

  @override
  _AddAddressDetailsScreenState createState() =>
      _AddAddressDetailsScreenState();
}

class _AddAddressDetailsScreenState extends State<AddAddressDetailsScreen> {
  final TextEditingController field1Controller = TextEditingController();
  final TextEditingController field2Controller = TextEditingController();
  final TextEditingController field3Controller = TextEditingController();
  final TextEditingController field4Controller = TextEditingController();
  final TextEditingController field5Controller = TextEditingController();

  late GoogleMapController mapController;
  late BitmapDescriptor customMarkerIcon;

  final Location _locationController = Location();
  String _address = "";

  LatLng? _currentLocation;

  final _formKey = GlobalKey<FormState>();

  bool _locationUpdated = false;
  bool confirmed = false;
  bool serviceavail = false;

  @override
  void initState() {
    super.initState();
    _getBytesFromAsset('Assets/Icons/Google_Marker.png').then((bytes) {
      setState(() {
        customMarkerIcon = BitmapDescriptor.fromBytes(bytes);
      });
    });
    requestLocationPermission();
    getLocationUpdates();
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus _permissionGranted =
        await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("Location permission is not granted.");
        return;
      }
    }
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        print("Location service is not enabled.");
        return;
      }
    }

    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (!_locationUpdated &&
          currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _updateCameraPosition();
        _getPlace();
        _locationUpdated = true;
        _locationController.onLocationChanged.listen(null);
      }
    });
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _currentLocation = position;
      _getPlace(); // Call _getPlace to retrieve address
    });
  }

  void _getPlace() async {
    List<ggg.Placemark> newPlace = await ggg.placemarkFromCoordinates(
        _currentLocation!.latitude, _currentLocation!.longitude);

    ggg.Placemark placeMark = newPlace[0];
    String? name = placeMark.name;

    String? thoroughfare = placeMark.thoroughfare;

    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? address =
        "${name}, ${thoroughfare}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}";

    setState(() {
      if (!widget.availablePinCodes.contains(postalCode)) {
        serviceavail = false;
      } else {
        serviceavail = true;
      }
      _address = address;
      field1Controller.text = name.toString();
      field2Controller.text = thoroughfare.toString();
      field3Controller.text = '$subLocality, $locality';

      field5Controller.text = postalCode.toString();
    });
  }

  void _updateCameraPosition() {
    if (_currentLocation != null && mapController != null) {
      mapController.animateCamera(CameraUpdate.newLatLng(_currentLocation!));
    }
  }

  void _submitForm(
      TextEditingController field1Controller,
      TextEditingController field2Controller,
      TextEditingController field3Controller,
      TextEditingController field4Controller) async {
    if (!widget.availablePinCodes.contains(field5Controller.text)) {
      setState(() {
        serviceavail = false;
        confirmed = false;
      });
    } else {
      if (_formKey.currentState!.validate()) {
        Map<String, dynamic> serviceDetails = {
          'HouseNoFloor': field1Controller.text,
          'BuildingStreet': field2Controller.text,
          'LandmarkAreaName': field3Controller.text,
          'Pincode': field5Controller.text,
          'Contact': field4Controller.text,
          'Latitude': _currentLocation!.latitude,
          'Longitude': _currentLocation!.longitude,
          'isSelected': true,
        };

        try {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(widget.uid)
              .collection('AddedAddress')
              .get()
              .then((querySnapshot) {
            for (QueryDocumentSnapshot doc in querySnapshot.docs) {
              doc.reference.update({'isSelected': false});
            }
          });

          await DatabaseHelper.addaddress(
            uid: widget.uid,
            serviceDetails: serviceDetails,
          );

          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Address add successfully'),
            ),
          );
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Address not added'),
            ),
          );
        }
      }
    }
  }

  Future<Uint8List> _getBytesFromAsset(String path) async {
    ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppbarWithCart(
        PageName: "Add Address Detail",
        iscart: false,
        uid: widget.uid,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.antiAlias, // Optional for smoother edges
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: 400,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition:
                    AddAddressDetailsScreen.initialCameraPosition,
                zoomControlsEnabled: false,

                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  _updateCameraPosition();
                },
                onTap: confirmed
                    ? null
                    : _selectLocation, // Conditionally set onTap
                scrollGesturesEnabled:
                    !confirmed, // Disable movement when confirmed is true
                zoomGesturesEnabled:
                    !confirmed, // Disable zoom when confirmed is true

                markers: {
                  if (_currentLocation != null)
                    Marker(
                      markerId: MarkerId('_currentLocation'),
                      icon: customMarkerIcon,
                      position: _currentLocation!,
                    ),
                },
              ),
            ),
            confirmed
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            confirmed = false;
                          }),
                          child: Text(
                            "Change",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'LexendRegular',
                                fontSize: 16,
                                color: darkBlueColor),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            _address.isEmpty
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.0, // Adjust height as needed
                          width: 30.0, // Adjust width as needed
                          child: CircularProgressIndicator(
                            color: darkBlueColor,
                            strokeWidth: 2.0,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Fetching Your Current Location",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'LexendRegular',
                              fontSize: 16,
                              color: blackColor),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'LexendRegular',
                                  fontSize: 14,
                                  color: blackColor),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Text(
                          _address,
                          style: TextStyle(
                              fontFamily: 'LexendRegular',
                              fontSize: 20,
                              color: blackColor),
                        ),
                      ),
                    ],
                  ),
            confirmed
                ? Form(
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
                          controller: field5Controller,
                          label: "Pincode",
                          limit: 6,
                          isnum: true,
                          minCharacters: 5,
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
                          function: () => _submitForm(
                            field1Controller,
                            field2Controller,
                            field3Controller,
                            field4Controller,
                          ),
                          isSelected: true,
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      CommonBtn(
                          BtnName: 'Edit and Save address',
                          function: onconfirmed,
                          isSelected: _currentLocation != null && serviceavail),
                      !serviceavail
                          ? Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                "Apologies, service isn't available here yet. Hang tight, we're working on it.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'LexendRegular',
                                    fontSize: 14,
                                    color: blackColor),
                              ),
                            )
                          : const SizedBox()
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  void onconfirmed() {
    setState(() {
      confirmed = true;
    });
  }
}
