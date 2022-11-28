// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';
import 'package:hive/hive.dart';

import '../../Utils/sqldatabase.dart';
import '../home.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final usernamecontroller = TextEditingController();
  sqlDataBase sqldatabase = sqlDataBase();
  @override
  Widget build(BuildContext context) {
    return ThewholeBody();
  }

  Widget ThewholeBody() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IntroductionScreen(
        scrollPhysics:
            const BouncingScrollPhysics(), //Default is BouncingScrollPhysics
        rawPages: [
          //If you don't want to use PageViewModel you can use this
          fst(), sec(), SingleChildScrollView(child: third())
        ],
        //If you provide both rawPages and pages parameter, pages will be used.
        onChange: (e) {
          // When something changes
        },
        onDone: () async {
          await Hive.openBox("boxname");
          final box = Hive.box('box');

          box.put('introduction', false);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const homeUtility();
              },
            ),
          );
        },
        onSkip: () {
          // You can also override onSkip callback
        },
        showSkipButton: true, //Is the skip button should be display
        skip: const Icon(
          Icons.skip_next,
          color: Color(0xFF6ecbf6),
        ),
        next: const Icon(Icons.forward, color: Color(0xFF6ecbf6)),
        done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),

        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: chameleon.color_hunt[3],
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }

  Widget third() {
    return Container(
      decoration: BoxDecoration(color: chameleon.color_hunt[1]),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
                    Text("INSERT YOUR USERNAME TO GET STARTED",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 180,
                    )
                  ],
                ),
                Lottie.asset('Assets/vending.json'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  child: TextField(
                    controller: usernamecontroller,
                    obscureText: false,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Username"),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: GestureDetector(
                onTap: () {
                  sqldatabase.adduser(usernamecontroller);
                  usernamecontroller.text = "";
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => homeUtility()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: chameleon.color_hunt[2],
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sec() {
    return Container(
      decoration: BoxDecoration(color: chameleon.color_hunt[4]),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Find balance in your life,\ntrack your habits and tasks,\nbe a better you.",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: chameleon.color_hunt[1],
                    fontSize: 37,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            Lottie.asset('Assets/balance.json'),
          ],
        ),
      ),
    );
  }

  Widget fst() {
    return Container(
      decoration: BoxDecoration(color: chameleon.color_hunt[0]),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.centerRight, children: [
              Column(
                children: [
                  Text(
                    "WELCOME TO NULIFE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: Text(
                        textAlign: TextAlign.start,
                        "Where your troubles end and your new life begins !",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal)),
                  ),
                  Lottie.asset('Assets/CP.json'),
                ],
              )
            ])
          ],
        ),
      ),
    );
  }
}
