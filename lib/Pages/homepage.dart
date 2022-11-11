// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:puzzeled_up/Pages/clonestamp.dart';
import 'package:puzzeled_up/Pages/timerStamp.dart';
import 'package:puzzeled_up/Pages/to_do_list.dart';

class homepage extends StatelessWidget {
  static List color_hunt = [
    Color(0xFF404258),
    Color(0xFF474E68),
    Color(0xFF6B728E),
    Color(0xFFFFECEF)
  ];
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: color_hunt[2],
          selectedItemColor: color_hunt[0],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xFF404258)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.celebration, color: Color(0xFF404258)),
              label: 'Achievements',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Color(0xFF404258)),
              label: 'Settings',
            ),
          ],
        ),
        backgroundColor: color_hunt[0],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    Text(
                      "Hey Leed,\nGlad to see you again",
                      style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'MS Gothic',
                          color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const toDoList()),
                            ),
                        child: buildabox("To-do List", "checklist")),
                    SizedBox(height: 50),
                    buildabox("Puzzled Up", "blocks"),
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
        ));
  }

  Widget buildabox(String txt, String img) {
    return Row(
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            decoration: BoxDecoration(
                color: color_hunt[1], borderRadius: BorderRadius.circular(25)),
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
