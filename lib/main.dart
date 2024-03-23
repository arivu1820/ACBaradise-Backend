import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';

import 'package:acbaradise/Controller/dependency.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Authentication/auth_page.dart';
import 'package:acbaradise/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());

  // Check for app update
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AC Baradise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: darkBlueColor),
        useMaterial3: true,
      ),
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AuthPage(),
      ),
    );
  }
}
