// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:puzzeled_up/Pages/homepage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2a2356),
      systemNavigationBarColor: Color(0xFF2a2356)));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const MaterialColor kPrimaryColor = const MaterialColor(
      0xFF2a2356,
      const <int, Color>{
        50: const Color(0xFF2a2356),
        100: const Color(0xFF2a2356),
        200: const Color(0xFF2a2356),
        300: const Color(0xFF2a2356),
        400: const Color(0xFF2a2356),
        500: const Color(0xFF2a2356),
        600: const Color(0xFF2a2356),
        700: const Color(0xFF2a2356),
        800: const Color(0xFF2a2356),
        900: const Color(0xFF2a2356),
      },
    );
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: homepage(),
    );
  }
}
