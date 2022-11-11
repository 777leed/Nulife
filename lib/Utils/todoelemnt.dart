// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class toDoElement extends StatelessWidget {
  final String prompt;

  toDoElement({required this.prompt});

  static List color_hunt = [
    Color(0xFF404258),
    Color(0xFF474E68),
    Color(0xFF6B728E),
    Color(0xFFFFECEF)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: color_hunt[2], borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                'Assets/check.png',
                height: 40,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(prompt,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'MS Gothic',
                        color: Colors.white)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}
