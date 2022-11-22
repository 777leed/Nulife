import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class gradient_lab extends StatelessWidget {
  static List<Color> color_hunt = [
    Color(0xFF101164),
    Color(0xFFf7b046),
    Color(0xFF2e1b93),
    Color(0xFFce554b)
  ];
  const gradient_lab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color_hunt[0], color_hunt[1]])));
  }
}
