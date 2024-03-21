import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Authentication/SigninScreen.dart';
import 'package:acbaradise/Authentication/auth_page.dart';
import 'package:acbaradise/Screens/ACProductScreen.dart';
import 'package:acbaradise/Screens/AddAddressDetailsScreen.dart';
import 'package:acbaradise/Screens/AnnualContractScreen.dart';
import 'package:acbaradise/Screens/HomeScreen.dart';
import 'package:acbaradise/Screens/MyCartScreen.dart';
import 'package:acbaradise/Screens/OrdersProductScreen.dart';
import 'package:acbaradise/Screens/OrdersScreen.dart';
import 'package:acbaradise/Screens/SelectAddressScreen.dart';
import 'package:acbaradise/Screens/ServiceScreen.dart';
import 'package:acbaradise/Screens/SubscriptionScreen.dart';
import 'package:acbaradise/Temp/temp.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Widgets/CombinedWidgets/AMCAdvantages.dart';
import 'package:acbaradise/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main()  async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AC Baradise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkBlueColor),
        useMaterial3: true,
        
      ),
      home: AuthPage(),
    );
  }
}
