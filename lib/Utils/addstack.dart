import 'package:flutter/material.dart';
import 'Chameleon.dart';

class plusbutton extends StatelessWidget {
  const plusbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: chameleon.color_hunt[1],
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 30,
          width: 30,
          child: Image.asset('Assets/plus.png'),
        )
      ],
    );
  }
}
