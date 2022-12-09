import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';

class dailyPlanner extends StatefulWidget {
  const dailyPlanner({super.key});

  @override
  State<dailyPlanner> createState() => _dailyPlannerState();
}

class _dailyPlannerState extends State<dailyPlanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: BoxDecoration(color: chameleon.color_hunt[1]),
        )
      ],
    ));
  }
}
