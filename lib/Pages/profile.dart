// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';
import '../Utils/sqldatabase.dart';

class myProfile extends StatefulWidget {
  const myProfile({super.key});

  @override
  State<myProfile> createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  sqlDataBase sqldatabase = sqlDataBase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: chameleon.color_hunt[0],
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.transparent,
      ),
      backgroundColor: chameleon.color_hunt[0],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              renderprofile(),
              SizedBox(
                height: 160,
              ),
              boxPluspicture()
            ],
          ),
        ),
      ),
    );
  }

  Widget boxPluspicture() {
    return Column(
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: Image.asset('Assets/bionic.png'),
        ),
        renderboxoftext()
      ],
    );
  }

  Widget renderboxoftext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: chameleon.color_hunt[1],
            borderRadius: BorderRadius.circular(10)),
        child: rendertext(),
      ),
    );
  }

  Widget rendertext() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textmaker(
            "Tasks accomplished : 77",
            Icon(
              Icons.add_task,
              color: chameleon.color_hunt[0],
            )),
        textmaker(
            "Time Spent: 1h 34m 11s",
            Icon(
              Icons.timelapse,
              color: chameleon.color_hunt[0],
            )),
        textmaker(
            "Abilities : 17 abilities",
            Icon(
              Icons.accessibility_outlined,
              color: chameleon.color_hunt[0],
            ))
      ],
    );
  }

  Widget textmaker(String txt, Icon ico) {
    return ListTile(
      textColor: chameleon.color_hunt[0],
      leading: ico,
      title: Text(txt),
    );
  }

  Widget renderprofile() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: chameleon.color_hunt[1],
                  borderRadius: BorderRadius.circular(100)),
            ),
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset('Assets/man.png'),
            )
          ],
        ),
        Container(
          alignment: Alignment.center,
          height: 30,
          width: 120,
          decoration: BoxDecoration(
              color: chameleon.color_hunt[4],
              borderRadius: BorderRadius.circular(10)),
          child: FutureBuilder(
              future: sqldatabase.greetings(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return Text(
                      "${snapshot.data![0]['name']}",
                      style: TextStyle(
                          color: chameleon.color_hunt[0],
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    );
                  }
                }

                return Text(
                  "User007",
                  style: TextStyle(color: Colors.white),
                );
              }),
        ),
      ],
    );
  }
}
