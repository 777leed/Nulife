// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:puzzeled_up/Pages/homepage.dart';
import 'package:puzzeled_up/Pages/timerStamp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    const MaterialColor kPrimaryColor = const MaterialColor(
      0xFF404258,
      const <int, Color>{
        50: const Color(0xFF404258),
        100: const Color(0xFF404258),
        200: const Color(0xFF404258),
        300: const Color(0xFF404258),
        400: const Color(0xFF404258),
        500: const Color(0xFF404258),
        600: const Color(0xFF404258),
        700: const Color(0xFF404258),
        800: const Color(0xFF404258),
        900: const Color(0xFF404258),
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
