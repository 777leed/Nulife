// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:puzzeled_up/Pages/home.dart';
import 'package:puzzeled_up/Pages/onboard/onboarding.dart';
import 'package:puzzeled_up/Pages/timerStamp.dart';
import 'package:puzzeled_up/Pages/to_do_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('box');
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
      routes: {
        '/home': (ctx) => homeUtility(),
        '/todolist': (ctx) => toDoList(),
        'timer': (ctx) => myTimer(),
      },
      theme: ThemeData(
        primarySwatch: kPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: homeUtility(),
    );
  }
}
