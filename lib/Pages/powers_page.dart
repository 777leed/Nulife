import 'package:flutter/material.dart';
import 'package:puzzeled_up/Models/Power/Power.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';
import 'package:puzzeled_up/Utils/Hive.dart';
import 'package:puzzeled_up/Utils/addstack.dart';
import 'package:puzzeled_up/Utils/myAppBar.dart';

import '../Utils/Power_tile.dart';
import '../Models/User/User.dart';
import '../Utils/sqldatabase.dart';

class showBait extends StatefulWidget {
  const showBait({super.key});

  @override
  State<showBait> createState() => _showBaitState();
}

class _showBaitState extends State<showBait> {
  User? currentUser = User.getCurrentUser();
  late List<Power>? powerList = getlist();
  sqlDataBase sqldatabase = sqlDataBase();
  var powerName = TextEditingController();
  var powerDesc = TextEditingController();
  List<Power>? getlist() {
    return currentUser!.PowerPuffs;
  }

  Future addPower(TextEditingController descController,
      TextEditingController nameController) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: chameleon.color_hunt[1],
              title: Text("Power Arsenal",
                  style:
                      TextStyle(fontFamily: 'MS Gothic', color: Colors.white)),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    cursorColor: chameleon.color_hunt[0],
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      focusColor: chameleon.color_hunt[0],
                      hintText: 'Add Your A Name Here',
                    ),
                  ),
                  TextField(
                    cursorColor: chameleon.color_hunt[0],
                    controller: descController,
                    autofocus: true,
                    decoration: InputDecoration(
                      focusColor: chameleon.color_hunt[0],
                      hintText: 'Add A Description Here',
                    ),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Power power = Power(nameController.text.trim(),
                          descController.text.trim(), 0);
                      HiveLab().addPower(power);
                      descController.text = "";
                      nameController.text = "";
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: Text("Add"))
              ],
            ));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chameleon.color_hunt[0],
      appBar: myAppBar(
        barTitle: "Power-Ups",
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: plusbutton(),
                  onTap: () {
                    addPower(powerDesc, powerName);
                  },
                )
              ],
            ),
            renderPowers()
          ],
        ),
      )),
    );
  }

  Widget renderPowers() {
    if (HiveLab().calcPowers() != 0) {
      return Expanded(
        child: GridView.builder(
          itemCount: powerList!.length,
          padding: EdgeInsets.all(12),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
          ),
          itemBuilder: (context, index) {
            return PowerTile(
              powerName: powerList![index].power_name,
              powerLevel: powerList![index].streak.toString(),
              powerColor: Colors.purple,
              imageName: "Assets/bionic.png",
            );
          },
        ),
      );
    }
    return Text("Nothing to see here");
  }
}
