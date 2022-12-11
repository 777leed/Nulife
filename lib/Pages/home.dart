// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:puzzeled_up/Models/User/User.dart';
import 'package:puzzeled_up/Pages/onboard/onboarding.dart';
import 'package:puzzeled_up/Pages/powers_page.dart';
import 'package:puzzeled_up/Pages/profile.dart';
import 'package:hive/hive.dart';
import 'package:puzzeled_up/Pages/timerStamp.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';
import '../Utils/sqldatabase.dart';

class homeUtility extends StatefulWidget {
  const homeUtility({super.key});

  @override
  State<homeUtility> createState() => _homeUtilityState();
}

class _homeUtilityState extends State<homeUtility> {
  sqlDataBase sqldatabase = sqlDataBase();
  final User? currentUser = User.getCurrentUser();

  Future<List<Map>> readData() async {
    List<Map> response =
        await sqldatabase.readData("SELECT count(*) AS numx FROM todolist");
    if (response.isEmpty) {}
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('box');
    final box1 = Hive.box('pfp');
    bool firstTimeState = box.get('introduction') ?? true;
    return firstTimeState
        ? MyWidget()
        : Scaffold(
            backgroundColor: chameleon.color_hunt[0],
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //heart
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: chameleon.color_hunt[1],
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('Assets/lovewins.png'),
                                ),
                                Text("x7")
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => myProfile()),
                        ),
                        child: Container(
                          height: 70,
                          width: 70,
                          child: box1.get("exist") == null
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: chameleon.color_hunt[1],
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                    ),
                                    SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Image.asset('Assets/man.png'),
                                    )
                                  ],
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      FileImage(File(box1.get("imagepath"))),
                                  radius: 200.0,
                                ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 30,
                            width: 120,
                            decoration: BoxDecoration(
                                color: chameleon.color_hunt[3],
                                borderRadius: BorderRadius.circular(10)),
                            child: FutureBuilder(
                                future: readData(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Map>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data!.isNotEmpty) {
                                      return Text(
                                        "Tasks left : ${snapshot.data![0]['numx']}",
                                        style: TextStyle(color: Colors.white),
                                      );
                                    }
                                  }

                                  return Center(
                                    child: Text(
                                      "Tasks left : ??",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }),
                          ),
                          //second bar
                          Container(
                            alignment: Alignment.center,
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                                color: chameleon.color_hunt[7],
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              "Lvl 9",
                              style: TextStyle(color: chameleon.color_hunt[4]),
                            ),
                            // child: LinearPercentIndicator(
                            //   percent: 0.5,
                            //   barRadius: Radius.circular(8),
                            //   lineHeight: 20,
                            //   fillColor: chameleon.color_hunt[4],
                            //   progressColor: chameleon.color_hunt[6],
                            //   backgroundColor: chameleon.color_hunt[4],
                            // ))
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    "Hey ${currentUser!.name},\nGlad to see you again",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'MS Gothic',
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(35),
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, '/todolist')
                                        .then((_) {
                                      // This block runs when you have returned back to the 1st Page from 2nd.
                                      setState(() {
                                        // Call setState to refresh the page.
                                      });
                                    }),
                                child: buildabox("To-do List", "checklist")),
                            SizedBox(height: 50),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => showBait()),
                                    ),
                                child: buildabox("Superpowers", "punch")),
                            SizedBox(height: 50),
                            GestureDetector(
                                onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => myTimer()),
                                    ),
                                child: buildabox("Timer", "timer"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

//this thing builds the 3 boxes so far and their titles as well
  Widget buildabox(String txt, String img) {
    return Row(
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            decoration: BoxDecoration(
                color: chameleon.color_hunt[1],
                borderRadius: BorderRadius.circular(25)),
            height: 80,
            width: 80,
          ),
          SizedBox(height: 60, width: 60, child: Image.asset('Assets/$img.png'))
        ]),
        SizedBox(
          width: 40,
        ),
        Text(txt,
            style: TextStyle(
                fontSize: 24, fontFamily: 'MS Gothic', color: Colors.white))
      ],
    );
  }
}
