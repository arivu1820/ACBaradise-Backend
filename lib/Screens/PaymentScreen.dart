
import 'package:acbaradise/Widgets/CombinedWidgets/PaymentMethod.dart';
import 'package:acbaradise/Widgets/SingleWidgets/AppbarWithCart.dart';
import 'package:acbaradise/Widgets/SingleWidgets/CommonBtn.dart';
import 'package:acbaradise/Widgets/SingleWidgets/SimplyExpand.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:acbaradise/Theme/Colors.dart";
import 'package:acbaradise/Widgets/CombinedWidgets/CashonDelivery.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Payment"),
        // You may replace this with your custom AppbarWithCart widget
      ),
      body: Column(
        children: [
          CashonDelivery(
            onSelectionChanged: (isSelected) {
              setState(() {
                isCashOnDeliverySelected = isSelected;
              });
            },
          ),
          PaymentMethod(amount: widget.amount),
          SimplyExpand(),
          CommonBtn(
            BtnName: "Confirm order to Proceed",
            function: () async {
              bool allProductsAvailable = await forproduct();

              if (allProductsAvailable) {
                await placeOrder();

                print("All products are available. Proceeding with the order.");
              } else {
                print(
                    "Not all products are available. Order cannot be processed.");
              }
            },
            isSelected: isCashOnDeliverySelected,
          ),
        ],
      ),
    );
  }

  Future<bool> forproduct() async {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['productdatalist'];
    List<Map<String, dynamic>> generalproductDataList =
        widget.allincart['generalproductlist'];

    for (var productData in productDataList) {
      print("Product ID: ${productData['productId']}");
      print("Category ID: ${productData['docId']}");
      print("Product Data: ${productData['productData']}");
      print("Count: ${productData['count']}");
      print("-------------------------------");

      bool stockAvailable = await checkStockAvailability(
          productData['productId'], productData['count']);

      if (!stockAvailable) {
        print("Not all products have sufficient stock.");
        return false;
      }
    }

    for (var productData in generalproductDataList) {
      print("Product ID: ${productData['productId']}");
      print("Category ID: ${productData['docId']}");
      print("Product Data: ${productData['productData']}");
      print("Count: ${productData['count']}");
      print("-------------------------------");

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

  Map<String, dynamic> productorderdetail() {
    List<Map<String, dynamic>> productDataList =
        widget.allincart['productdatalist'];
    List<Map<String, dynamic>> orderproductdetail = [];

    for (var productData in productDataList) {
      print("Product ID: ${productData['productId']}");
      print("Category ID: ${productData['docId']}");
      print("Product Data: ${productData['productData']}");
      print("Count: ${productData['count']}");

      // Get necessary data from productData
      String productId = productData['productId'];
      String categoryId = productData['docId'];
      int count = productData['count'];
      String title = productData['productData']['Name'];
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
      print("Product ID: ${productData['productId']}");
      print("Category ID: ${productData['docId']}");
      print("Product Data: ${productData['productData']}");
      print("Count: ${productData['count']}");

      // Get necessary data from productData
      String productId = productData['productId'];
      int count = productData['count'];
      String title = productData['productData']['Name'];
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
      print("Product ID: ${productData['productId']}");
      print("Category ID: ${productData['collectionName']}");
      print("Product Data: ${productData['productData']}");
      print("Count: ${productData['count']}");

      bool isYes = productData['is360degree'] ?? false;
      String productId = productData['productId'];
      String categoryId = productData['collectionName'];
      int count = productData['count'];
      String title = productData['productData']['Title'];
      // String img = productData['productData']['Image'];
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
      print(".............");
      print("Product ID: ${productData['productId']}");
      print("Category ID: ${productData['collectionName']}");
      print("Product Data: ${productData['productData']}");
      print("Count: ${productData['count']}");

      String productId = productData['productId'];
      // Assuming 'collectionName' is still relevant for AMC, adjust if needed
      String categoryId = productData['collectionName'];
      int count = productData['count'];
      bool isYes = productData['UseTotalSpares'];
      String title = productData['productData']['Content']['Title'];
      List benefits = productData['productData']['Content']['Benefits'];
      List images = productData['productData']['Content']['Images'];

      num discount = productData['productData']['Content']['Discount'] ?? 0;
      num mrp = productData['productData']['Content']['MRP'] ?? 0;
      num totalSparesPrice =
          productData['productData']['Content']['TotalSparesPrice'] ?? 0;
      num discountedPrice = isYes
          ? (mrp + totalSparesPrice) -
              ((mrp + totalSparesPrice) * discount / 100)
          : mrp - (mrp * discount / 100);

      num totalPrice = discountedPrice * count;

      orderProductDetail.add({
        'productId': productId,
        'count': count,
        'title': title,
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
        'totalPrice': productData['totalPrice'],
        'benefits': productData['benefits'],
        'images': productData['images'],
      };
    }

    // Store order details in Firestore under Users -> uid -> Orders -> orderId

    return orderDetails;
  }

  Future<void> placeOrder() async {
    String name = '';
    String email = '';
    String address = '';
    String contact = '';

    Map<String, dynamic> product = await productorderdetail();
    Map<String, dynamic> service = await serviceorderdetail();
    Map<String, dynamic> amc = await amcorderdetail();
    Map<String, dynamic> generalproduct = await generalproductorderdetail();

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
            contact = addedAddressDoc['Contact'];

            // Add more fields as needed...

            // Concatenate fields into the address string
            address =
                '$building ,$street, $LandmarkAreaName'; // Adjust the format as needed

            // If 'isSelected' is true, exit the loop
            break;
          }
        }
      }
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.uid)
          .collection('Orders')
          .doc(widget.uniqueid)
          .set({
        'OrderDetails': orderDetails,
        'CreatedAt': Timestamp.now(),
        'email': email,
        'name': name,
        'address': address,
        'contact': contact,
        'totalamount': widget.amount,
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
      }

      // Set product title
      await productRef
          .set({'title': productData['title']}, SetOptions(merge: true));
    }
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
}
