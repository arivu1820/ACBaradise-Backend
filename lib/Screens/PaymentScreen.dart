import 'package:acbaradise/Screens/OrdersScreen.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CommonBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SimplyExpand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:acbaradise/Theme/Colors.dart";
import 'package:acbaradise/Widgets/CombinedWidgets/CashonDelivery.dart';
import 'package:flutter/widgets.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  final String uid;
  final num amount;
  final String uniqueid;
  final Map<String, dynamic> allincart;

  PaymentScreen({
    Key? key,
    required this.uid,
    required this.amount,
    required this.allincart,
    required this.uniqueid,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCashOnDeliverySelected = false;
  bool issubmited = false;
  String name = '';
  String email = '';
  String address = '';
  String contact = '';
  String latitude = '';
  String longitude = '';
  String orderTitle = '';

  final Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    //  final Razorpay _razorpay = Razorpay();
    // To handle different events with previous functions
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void openCheckout(num totalamount) async {
    totalamount = totalamount * 100;
    var options = {
      // Razorpay API Key
      'key': 'rzp_live_un1Rk060cMTIoP',
      // in the smallest
      // currency sub-unit.
      'amount': totalamount,
      "currency": "INR",
      // 'name': 'AC Baradise',
      // Generate order_id
      // using Orders API
      // 'order_id': 'adfasdfasddsa',
      // Order Description to be
      // shown in razor pay page
      'description': 'order id',
      // in seconds
      'timeout': 300,
      // in seconds
      'prefill': {
        'contact': contact,
        'email': email,
        'name': name,
        'address': address,
      } // contact number and email id of user
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('error...............................................');
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await placeOrder('online');

    const snackDemo = SnackBar(
      content: Text("Your Order Placed Successfully"),
      backgroundColor: leghtGreen,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);
    removeAllCarts(widget.uid);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrdersScreen(uid: widget.uid),
        ));
    setState(() {
      issubmited = false;
    });
    print("All products are available. Proceeding with the order.");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      issubmited = false;
    });

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: GestureDetector(
          onTap: () {
            launch('https://acbaradise.com/support');
          },
          child: Row(
            children: [
              Text(
                "Payment failed. ",
                style: TextStyle(color: whiteColor),
              ),
              Text(
                "Contact support center ",
                style: TextStyle(
                  color: whiteColor,
                  decoration: TextDecoration.underline,
                            decorationColor: whiteColor,

                ),
              ),
              Text(
                "for queries",
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: brownColor,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    const snackDemo = SnackBar(
      content: Text("External wallet selected."),
      backgroundColor: darkBlueColor,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);

    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar:
          AppbarWithCart(PageName: 'Payment', iscart: false, uid: widget.uid),
      // You may replace this with your custom AppbarWithCart widget

      body: issubmited
          ? Center(
              child: const CircularProgressIndicator(
              color: darkBlueColor,
              strokeWidth: 2,
            ))
          : Column(
              children: [
                if (widget.amount < 1000)
                  CashonDelivery(
                    onSelectionChanged: (isSelected) {
                      setState(() {
                        isCashOnDeliverySelected = isSelected;
                      });
                    },
                  ),
                GestureDetector(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // title: const Text('Payment'),
                          content: const Text(
                            "Please don't navigate away until your payment has been confirmed through our service. Thank you for your cooperation.",
                            style: TextStyle(
                                fontFamily: 'LexendRegular',
                                fontSize: 16,
                                color: blackColor),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                bool allProductsAvailable = await forproduct();
                                if (allProductsAvailable) {
                                  openCheckout(widget.amount);
                                } else {
                                  const snackDemo = SnackBar(
                                    content: Text("Remove Out of Stock Items"),
                                    backgroundColor: brownColor,
                                    elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(5),
                                    duration: Duration(seconds: 5),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackDemo);
                                  setState(() {
                                    issubmited = false;
                                  });
                                  print(
                                      "Not all products are available. Order cannot be processed.");
                                } // Close the dialog
                              },
                              child: Text(
                                'OK',
                                style: TextStyle(
                                    fontFamily: 'LexendRegular',
                                    fontSize: 14,
                                    color: darkBlueColor),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    setState(() {
                      issubmited = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, top: 30, bottom: 30, right: 20),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: lightBlue30Color,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: lightBlueColor),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Image.asset(
                            "Assets/Icons/Payment_method_icon.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                        const SizedBox(width: 30),
                        const Expanded(
                          child: Text(
                            "Pay Through Online",
                            style: TextStyle(
                              fontFamily: "OxygenRegular",
                              fontSize: 16,
                              color: blackColor,
                            ),
                          ),
                        ),
                        Image.asset(
                          "Assets/Icons/ArrowRight.png",
                          height: 20,
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
                SimplyExpand(),
                CommonBtn(
                  BtnName: "Confirm order to Proceed",
                  function: () => callorderconfirm(),
                  isSelected: isCashOnDeliverySelected,
                ),
              ],
            ),
    );
  }

  Future<void> callorderconfirm() async {
    setState(() {
      issubmited = true;
    });
    bool allProductsAvailable = await forproduct();
    if (allProductsAvailable) {
      await placeOrder('offline');

      const snackDemo = SnackBar(
        content: Text("Your Order Placed Successfully"),
        backgroundColor: leghtGreen,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackDemo);
      removeAllCarts(widget.uid);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrdersScreen(uid: widget.uid),
          ));
      print("All products are available. Proceeding with the order.");
    } else {
      const snackDemo = SnackBar(
        content: Text("Remove Out of Stock Items"),
        backgroundColor: brownColor,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackDemo);
      setState(() {
        issubmited = false;
      });
      print("Not all products are available. Order cannot be processed.");
    }
  }

  Future<bool> forproduct() async {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['productdatalist'];
    List<Map<String, dynamic>> generalproductDataList =
        widget.allincart['generalproductlist'];

    for (var productData in productDataList) {
      bool stockAvailable = await checkStockAvailability(
          productData['productId'], productData['count']);

      if (!stockAvailable) {
        print("Not all products have sufficient stock.");
        return false;
      }
    }

    for (var productData in generalproductDataList) {
      bool stockAvailable = await generalcheckStockAvailability(
          productData['productId'], productData['count']);

      if (!stockAvailable) {
        print("Not all products have sufficient stock.");
        return false;
      }
    }

    print("All products have sufficient stock.");
    return true;
  }

  Future<bool> checkStockAvailability(String productId, int count) async {
    QuerySnapshot productsSnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    for (var categoryDoc in productsSnapshot.docs) {
      String categoryId = categoryDoc.id;

      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('Categories')
          .doc(categoryId)
          .collection('Products')
          .doc(productId)
          .get();

      if (productDoc.exists) {
        int stock = productDoc['Stock'] ?? 0;

        if (count > stock) {
          print(
              "Stock not available for Product ID $productId in Category ID $categoryId");
          return false;
        }
      }
    }

    return true;
  }

  Future<bool> generalcheckStockAvailability(
      String productId, int count) async {
    QuerySnapshot productsSnapshot =
        await FirebaseFirestore.instance.collection('GeneralProducts').get();

    for (var categoryDoc in productsSnapshot.docs) {
      String categoryId = categoryDoc.id;

      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('GeneralProducts')
          .doc(productId)
          .get();

      if (productDoc.exists) {
        int stock = productDoc['Stock'] ?? 0;

        if (count > stock) {
          print(
              "Stock not available for generalProduct ID $productId in Category ID $categoryId");
          return false;
        }
      }
    }

    return true;
  }

  Future<void> removeAllCarts(String userId) async {
    try {
      // Remove AMCCart coll
      await _deleteCollection(FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('GeneralProductsCart'));

      await _deleteCollection(FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('AMCCart'));

      // Remove ServicesCart collection
      await _deleteCollection(FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('ServicesCart'));

      // Remove GeneralProductsCart collection
      await _deleteCollection(FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('ProductsCart'));

      print("All carts removed for user $userId.");
    } catch (e) {
      print("Error removing carts: $e");
    }
  }

  Future<void> _deleteCollection(CollectionReference collectionRef) async {
    try {
      QuerySnapshot snapshot = await collectionRef.get();

      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print("Error deleting collection: $e");
    }
  }

  Map<String, dynamic> productorderdetail() {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['productdatalist'];
    List<Map<String, dynamic>> orderproductdetail = [];

    for (var productData in productDataList) {
      // Get necessary data from productData
      String productId = productData['productId'];
      String categoryId = productData['docId'];
      int count = productData['count'];
      if (count <= 0) {
        continue;
      }
      String title = productData['productData']['Name'];
      if (orderTitle == '') {
        orderTitle = title;
      } else {
        orderTitle = orderTitle + ', ' + title;
      }

      String img = productData['productData']['Images'][0];
      num discount = productData['productData']['Discount'] ?? 0;
      num mrp = productData['productData']['MRP'] ?? 0;

      num discountedPrice = mrp - (mrp * discount / 100);

      num totalPrice = discountedPrice * count;

      // Create a map for each product and add it to the orderproductdetail list
      orderproductdetail.add({
        'productId': productId,
        'categoryId': categoryId,
        'count': count,
        'title': title,
        'img': img,
        'totalPrice': totalPrice,
        // Add any additional fields you want to store
      });
    }

    // Generate a random ID for the order
    String orderId = FirebaseFirestore.instance.collection('Users').doc().id;

    // Create a map to store the products directly under the 'Products' field
    Map<String, dynamic> orderDetails = {
      'Products': {},
    };

    // Populate the 'Products' map with product details
    for (var productData in orderproductdetail) {
      String productId = productData['productId'];
      orderDetails['Products'][productId] = {
        'categoryId': productData['categoryId'],
        'count': productData['count'],
        'title': productData['title'],
        'img': productData['img'],
        'totalPrice': productData['totalPrice'],
        // Add any additional fields you want to store
      };
    }

    return orderDetails;
  }

  Map<String, dynamic> generalproductorderdetail() {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['generalproductlist'];
    List<Map<String, dynamic>> orderproductdetail = [];

    for (var productData in productDataList) {
      // Get necessary data from productData
      String productId = productData['productId'];
      int count = productData['count'];
      if (count <= 0) {
        continue;
      }
      String title = productData['productData']['Name'];
      if (orderTitle == '') {
        orderTitle = title;
      } else {
        orderTitle = orderTitle + ', ' + title;
      }
      String img = productData['productData']['Image'];
      num discount = productData['productData']['Discount'] ?? 0;
      num mrp = productData['productData']['MRP'] ?? 0;

      num discountedPrice = mrp - (mrp * discount / 100);

      num totalPrice = discountedPrice * count;

      // Create a map for each product and add it to the orderproductdetail list
      orderproductdetail.add({
        'productId': productId,
        'count': count,
        'title': title,
        'img': img,
        'totalPrice': totalPrice,
        // Add any additional fields you want to store
      });
    }

    // Generate a random ID for the order
    String orderId = FirebaseFirestore.instance.collection('Users').doc().id;

    // Create a map to store the products directly under the 'Products' field
    Map<String, dynamic> orderDetails = {
      'GeneralProducts': {},
    };

    // Populate the 'Products' map with product details
    for (var productData in orderproductdetail) {
      String productId = productData['productId'];
      orderDetails['GeneralProducts'][productId] = {
        'categoryId': productData['categoryId'],
        'count': productData['count'],
        'title': productData['title'],
        'img': productData['img'],
        'totalPrice': productData['totalPrice'],
        // Add any additional fields you want to store
      };
    }

    return orderDetails;
  }

  Map<String, dynamic> serviceorderdetail() {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['servicedatalist'];
    List<Map<String, dynamic>> orderproductdetail = [];

    for (var productData in productDataList) {
      bool isYes = productData['is360degree'] ?? false;
      String productId = productData['productId'];
      String categoryId = productData['collectionName'];
      int count = productData['count'];
      if (count <= 0) {
        continue;
      }
      String title = productData['productData']['Title'];
      if (orderTitle == '') {
        orderTitle = title;
      } else {
        orderTitle = orderTitle + ', ' + title;
      }
      num discount = productData['productData']['Discount'] ?? 0;
      num mrp = productData['productData']['MRP'] ?? 0;
      num is360degreeprice = productData['productData']['Wash360Price'] ?? 0;

      num discountedPrice = isYes
          ? (mrp + is360degreeprice) -
              ((mrp + is360degreeprice) * discount / 100)
          : mrp - (mrp * discount / 100);
      num totalPrice = discountedPrice * count;

      // Create a map for each product and add it to the orderproductdetail list
      orderproductdetail.add({
        'productId': productId,
        'categoryId': categoryId,
        'count': count,
        'title': title,
        // 'img': img,
        'totalPrice': totalPrice,
        // Add any additional fields you want to store
      });
    }

    // Generate a random ID for the order
    String orderId = FirebaseFirestore.instance.collection('Users').doc().id;

    // Create a map to store the products directly under the 'Products' field
    Map<String, dynamic> orderDetails = {
      'Services': {},
    };

    // Populate the 'Products' map with product details
    for (var productData in orderproductdetail) {
      String productId = productData['productId'];
      orderDetails['Services'][productId] = {
        'categoryId': productData['categoryId'],
        'count': productData['count'],
        'title': productData['title'],
        'totalPrice': productData['totalPrice'],
        // Add any additional fields you want to store
      };
    }

    return orderDetails;
    // Store order details in Firestore under Users -> uid -> Orders -> orderId
  }

  Map<String, dynamic> amcorderdetail() {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['amcdatalist'];
    List<Map<String, dynamic>> orderProductDetail = [];

    for (var productData in productDataList) {
      String productId = productData['productId'];
      // Assuming 'collectionName' is still relevant for AMC, adjust if needed
      String categoryId = productData['collectionName'];
      int count = productData['count'];

      if (count <= 0) {
        continue;
      }

      bool isYes = productData['UseTotalSpares'];
      String title = productData['productData']['Content']['Title'];
      if (orderTitle == '') {
        orderTitle = title;
      } else {
        orderTitle = orderTitle + ', ' + title;
      }

      List benefits = productData['productData']['Content']['Benefits'];
      List images = productData['productData']['Content']['Images'];
      List TotalSparesbenefits =
          productData['productData']['Content']['TotalSpares'];

      num discount = productData['productData']['Content']['Discount'] ?? 0;
      num mrp = productData['productData']['Content']['MRP'] ?? 0;
      num totalSparesPrice =
          productData['productData']['Content']['TotalSparesMRP'] ?? 0;
      num discountedPrice = isYes
          ? (mrp + totalSparesPrice) -
              ((mrp + totalSparesPrice) * discount / 100)
          : mrp - (mrp * discount / 100);

      num totalPrice = discountedPrice * count;

      orderProductDetail.add({
        'productId': productId,
        'count': count,
        'title': title,
        'SparesIncluded': isYes,
        'SparesBenefits': TotalSparesbenefits,
        'TotalSparesPrice': totalSparesPrice,
        'totalPrice': totalPrice,
        'benefits': benefits,
        'images': images,
      });
    }

    // Create a map to store the products directly under the 'AMC' field
    Map<String, dynamic> orderDetails = {
      'AMC': {},
    };

    // Populate the 'AMC' map with product details
    for (var productData in orderProductDetail) {
      String productId = productData['productId'];
      orderDetails['AMC'][productId] = {
        'count': productData['count'],
        'title': productData['title'],
        'SparesIncluded': productData['SparesIncluded'],
        'TotalSparesPrice': productData['TotalSparesPrice'],
        'SparesBenefits': productData['SparesBenefits'],
        'totalPrice': productData['totalPrice'],
        'benefits': productData['benefits'],
        'images': productData['images'],
      };
    }

    // Store order details in Firestore under Users -> uid -> Orders -> orderId

    return orderDetails;
  }

  Future<void> placeOrder(String orderPayment) async {
    Map<String, dynamic> product = await productorderdetail();
    Map<String, dynamic> service = await serviceorderdetail();
    Map<String, dynamic> amc = await amcorderdetail();
    Map<String, dynamic> generalproduct = await generalproductorderdetail();
    Timestamp time = Timestamp.now();

    List<Map<String, dynamic>> orderDetails = [
      amc,
      service,
      product,
      generalproduct
    ];

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .get();

      // Check if user document exists
      if (userSnapshot.exists) {
        // Get 'name' and 'email' from user document
        name = userSnapshot['name'];
        email = userSnapshot['email'];

        // Get 'AddedAddress' subcollection reference
        CollectionReference addedAddressCollection =
            userSnapshot.reference.collection('AddedAddress');

        // Get documents from 'AddedAddress' subcollection
        QuerySnapshot addedAddressQuery = await addedAddressCollection.get();

        // Iterate through documents in 'AddedAddress' subcollection

        // Iterate through documents in 'AddedAddress' subcollection
        for (QueryDocumentSnapshot addedAddressDoc in addedAddressQuery.docs) {
          // Check if 'isSelected' field is true
          if (addedAddressDoc['isSelected'] == true) {
            // Get other fields from the document
            String street = addedAddressDoc['BuildingStreet'];
            String building = addedAddressDoc['HouseNoFloor'];

            String LandmarkAreaName = addedAddressDoc['LandmarkAreaName'];
            String pincode = addedAddressDoc['Pincode'];

            contact = addedAddressDoc['Contact'];
            latitude = addedAddressDoc['Latitude'].toString();

            longitude = addedAddressDoc['Longitude'].toString();

            // Add more fields as needed...

            // Concatenate fields into the address string
            address =
                '$building ,$street, $LandmarkAreaName, $pincode'; // Adjust the format as needed

            // If 'isSelected' is true, exit the loop
            break;
          }
        }
      }
      await reduceStockForProduct(widget.uid, product);
      await reduceStockForGeneralProduct(widget.uid, generalproduct);
      await FirebaseFirestore.instance
          .collection('CurrentOrders')
          .doc(widget.uniqueid)
          .set({
        'OrderDetails': orderDetails,
        'UID': widget.uid,
        'CreatedAt': time,
        'email': email,
        'name': name,
        'lat': latitude,
        'lon': longitude,
        'address': address,
        'contact': contact,
        'totalamount': widget.amount,
        'orderTitle': orderTitle,
        'orderPayment': orderPayment,
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection('Orders')
          .doc(widget.uniqueid)
          .set({
        'OrderDetails': orderDetails,
        'CreatedAt': time,
        'email': email,
        'name': name,
        'lat': latitude,
        'lon': longitude,
        'address': address,
        'contact': contact,
        'totalamount': widget.amount,
        'orderTitle': orderTitle,
        'orderPayment': orderPayment,
      });
      await storeAMCDataInFirestore(widget.uid);
      print(
          'Order details stored successfully with Order ID....: $orderDetails');
    } catch (error) {
      print('Error storing order details: $error');
    }
  }

  Future<void> storeAMCDataInFirestore(String uid) async {
    // Call the amcorderdetail method to get the order details
    Map<String, dynamic> orderDetails = amcorderdetail();

    // Construct the Firestore path
    String firestorePath = 'Users/$uid/AMC Subscription';
    Uuid uuid = Uuid();

    // Iterate through the 'AMC' map in orderDetails
    for (var entry in orderDetails['AMC'].entries) {
      String productId = entry.key;
      Map<String, dynamic> productData = entry.value;
      int count = productData['count'];

      // Create a new document under the productId
      DocumentReference productRef =
          FirebaseFirestore.instance.collection(firestorePath).doc(productId);

      // Iterate through the count to generate unique IDs
      for (int i = 0; i < count; i++) {
        String randomId = uuid.v4();
        DateTime currentTimestamp = DateTime.now();

        // Calculate service intervals and build data map
        Map<String, dynamic> dataToMerge = {
          'Benefits': productData['benefits'],
          'Images': productData['images'],
          'SparesIncluded': productData['SparesIncluded'],
          'SparesBenefits': productData['SparesBenefits'],
          'Claimed1': false,
          'Claimed2': false,
          'Claimed3': false,
          'Claimed4': false,
          'Avail': true,
        };

        // Define the service intervals (1, 2, 3 months)
        List<int> serviceIntervals = [0, 4, 8, 12];

        for (int interval in serviceIntervals) {
          DateTime serviceTimestamp = addMonths(currentTimestamp, interval);
          dataToMerge['Service$interval'] = {
            'Timestamp': serviceTimestamp,
            'IsDone': false
          };
        }

        // Create a map with the randomId as key
        Map<String, dynamic> dataToMergeWithId = {randomId: dataToMerge};

        // Use set with merge option to add or update the data
        await productRef.set(
            {"SchemeCollection": dataToMergeWithId}, SetOptions(merge: true));

        // Call storeAMCDataInadmin for each product
        await storeAMCDataInadmin(
            uid, name, contact, address, productId, randomId, productData);
      }

      // Set product title
      await productRef
          .set({'title': productData['title']}, SetOptions(merge: true));
    }
  }

  Future<void> storeAMCDataInadmin(
      String uid,
      String name,
      String contact,
      String address,
      String productId,
      String randomId,
      Map<String, dynamic> productData) async {
    // Construct the Firestore path
    String firestorePath = 'CurrentAMCSubscription';

    // Create a new document for each product
    DocumentReference productRef =
        FirebaseFirestore.instance.collection(firestorePath).doc('$randomId');

    DateTime currentTimestamp = DateTime.now();

    // Calculate service intervals and build data map
    Map<String, dynamic> dataToMerge = {
      'Benefits': productData['benefits'],
      'Images': productData['images'],
      'SparesIncluded': productData['SparesIncluded'],
      'SparesBenefits': productData['SparesBenefits'],
      'Claimed': false,
      'Name': name,
      'Contact': contact,
      'Address': address,
      'Avail': true,
      'Image': '',
      'Title': productData['title'],
      'UID': uid,
    };

    // Define the service intervals (1, 2, 3 months)
    List<int> serviceIntervals = [0, 4, 8, 12];

    for (int interval in serviceIntervals) {
      DateTime serviceTimestamp = addMonths(currentTimestamp, interval);
      dataToMerge['Service$interval'] = {
        'Timestamp': serviceTimestamp,
        'IsDone': false
      };
    }

    // Set product title
    dataToMerge['title'] = productData['title'];

    // Use set to add the data
    await productRef.set(dataToMerge);
  }

  DateTime addMonths(DateTime dateTime, int months) {
    return DateTime(
        dateTime.year,
        dateTime.month + months,
        dateTime.day,
        dateTime.hour,
        dateTime.minute,
        dateTime.second,
        dateTime.millisecond,
        dateTime.microsecond);
  }

  Future<void> reduceStockForProduct(
      String userId, Map<String, dynamic> product) async {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['productdatalist'];

    for (var productData in productDataList) {
      String productId = productData['productId'];
      int count = productData['count'];

      await updateProductStock(userId, productId, count);
    }
  }

  Future<void> reduceStockForGeneralProduct(
      String userId, Map<String, dynamic> generalproduct) async {
    List<Map<String, dynamic>> generalproductDataList =
        widget.allincart['generalproductlist'];

    for (var productData in generalproductDataList) {
      String productId = productData['productId'];
      int count = productData['count'];

      await updateGeneralProductStock(userId, productId, count);
    }
  }

  Future<void> updateProductStock(
      String userId, String productId, int count) async {
    QuerySnapshot productsSnapshot =
        await FirebaseFirestore.instance.collection('Categories').get();

    for (var categoryDoc in productsSnapshot.docs) {
      String categoryId = categoryDoc.id;

      DocumentReference productDocRef = FirebaseFirestore.instance
          .collection('Categories')
          .doc(categoryId)
          .collection('Products')
          .doc(productId);

      DocumentSnapshot productDoc = await productDocRef.get();

      if (productDoc.exists) {
        int currentStock = productDoc['Stock'] ?? 0;
        int newStock = currentStock - count;
        if (newStock < 0) {
          newStock = 0; // Ensure stock doesn't go negative
        }

        // Update stock in Firestore
        await productDocRef.update({'Stock': newStock});
      }
    }
  }

  Future<void> updateGeneralProductStock(
      String userId, String productId, int count) async {
    try {
      // Get the reference to the product document
      DocumentReference productDocRef = FirebaseFirestore.instance
          .collection('GeneralProducts')
          .doc(productId);

      // Get the current stock of the product
      DocumentSnapshot productDoc = await productDocRef.get();
      if (productDoc.exists) {
        int currentStock = productDoc['Stock'] ?? 0;

        // Calculate new stock value after reducing the count
        int newStock = currentStock - count;
        if (newStock < 0) {
          newStock = 0; // Ensure stock doesn't go negative
        }

        // Update stock in Firestore
        await productDocRef.update({'Stock': newStock});
      }
    } catch (error) {
      print('Error updating general product stock: $error');
    }
  }
}
