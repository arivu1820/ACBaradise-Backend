import 'package:acbaradise/Controller/dependency.dart';
import 'package:acbaradise/Theme/Colors.dart';
import 'package:acbaradise/Authentication/auth_page.dart';

import 'package:acbaradise/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

Future<void> main()  async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
    // DependencyInjection.init();

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
