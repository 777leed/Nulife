import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';

import '../Utils/Power_tile.dart';

class showBait extends StatefulWidget {
  const showBait({super.key});

  @override
  State<showBait> createState() => _showBaitState();
}

class _showBaitState extends State<showBait> {
  List donutsOnSale = [
    // [ powerName, powerLevel, powerColor, imageName ]
    ["Touch Typing", "36", Colors.blue, "Assets/bionic.png"],
    ["Box Breathing", "45", Colors.red, "Assets/bionic.png"],
    ["Chess", "84", Colors.purple, "Assets/bionic.png"],
    ["Morse Code", "95", Colors.brown, "Assets/bionic.png"],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: chameleon.color_hunt[0],
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: donutsOnSale.length,
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
              ),
              itemBuilder: (context, index) {
                return PowerTile(
                  powerName: donutsOnSale[index][0],
                  powerLevel: donutsOnSale[index][1],
                  powerColor: donutsOnSale[index][2],
                  imageName: donutsOnSale[index][3],
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
