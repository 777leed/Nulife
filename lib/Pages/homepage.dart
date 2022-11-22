// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:puzzeled_up/Pages/timerStamp.dart';
import 'package:puzzeled_up/Pages/to_do_list.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';

class homepage extends StatelessWidget {
  // static List color_hunt = [
  //   Color(0xFF404258),
  //   Color(0xFF474E68),
  //   Color(0xFF6B728E),
  //   Color(0xFFFFECEF)
  // ];
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: chameleon.color_hunt[0],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
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
              Text(
                "Hey Leed,\nGlad to see you again",
                style: TextStyle(
                    fontSize: 28, fontFamily: 'MS Gothic', color: Colors.white),
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
                            onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const toDoList()),
                                ),
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
