import 'package:flutter/material.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentMethod extends StatefulWidget {
  final num amount;
  PaymentMethod({Key? key,required this.amount});
  

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final Razorpay _razorpay = Razorpay();

  // final razorpaykey = dotenv.get('rzp_test_bEVQhaC3E9rBPZ');


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
          'description': 
              'order id',  
          // in seconds 
          'timeout': 300, 
      // in seconds
      'prefill': {
        'contact': '9123456789',
        'email': 'flutterwings304@gmail.com'
      } // contact number and email id of user
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('error...............................................');
    }
  }

Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Future.delayed(Duration(seconds: 6));

  const snackDemo = SnackBar(
    content: Text("Payment successful!"),
    backgroundColor: leghtGreen,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
    duration: Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackDemo);
}

void _handlePaymentError(PaymentFailureResponse response) {
  // Navigator.of(context).pop();
  const snackDemo = SnackBar(
    content: Text("Payment failed. Please try again."),
    backgroundColor: brownColor,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
    duration: Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackDemo);

  // Do something when payment fails
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


  // @override
  // void dispose() {
  //   super.dispose();
  //   _razorpay.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 30, bottom: 30, right: 20),
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
          IconButton(
              onPressed: () {
                openCheckout(widget.amount);
              },
              icon: Image.asset(
                "Assets/Icons/ArrowRight.png",
                height: 20,
                width: 10,
              ))
        ],
      ),
    );
  }
}
