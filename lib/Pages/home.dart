// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:puzzeled_up/Pages/onboard/onboarding.dart';
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

  Future<List<Map>> readData() async {
    List<Map> response =
        await sqldatabase.readData("SELECT count(*) AS numx FROM todolist");
    if (response.isEmpty) {}
    return response;
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('box');
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => myProfile()),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: chameleon.color_hunt[1],
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset('Assets/man.png'),
                            )
                          ],
                        ),
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
                      )
                    ],
                  ),
                  FutureBuilder(
                      future: sqldatabase.greetings(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return Text(
                              "Hey ${snapshot.data![0]['name']},\nGlad to see you again",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: 'MS Gothic',
                                  color: Colors.white),
                              textAlign: TextAlign.left,
                            );
                          }
                        }

                        return Text(
                          "User007",
                          style: TextStyle(color: Colors.white),
                        );
                      }),
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
                            buildabox("Superpowers", "punch"),
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
