import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:puzzeled_up/Utils/Chameleon.dart';

class dailyPlanner extends StatefulWidget {
  const dailyPlanner({super.key});

  @override
  State<dailyPlanner> createState() => _dailyPlannerState();
}

class _dailyPlannerState extends State<dailyPlanner> {
  File? _image;
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
