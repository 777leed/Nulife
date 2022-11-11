// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class myTimer extends StatefulWidget {
  const myTimer({super.key});

  @override
  State<myTimer> createState() => _myTimerState();
}

class _myTimerState extends State<myTimer> {
  final List color_hunt = [
    Color(0xFF404258),
    Color(0xFF474E68),
    Color(0xFF6B728E),
    Color(0xFFFFECEF)
  ];
  double percentage = 0;
  int countclicks = 0;
  double perk = 0;
  int timeleft = 0;
  Timer? _mytimer;
  bool stopped = false;

  void _countodown() {
    if (stopped == false) {
      _mytimer = Timer.periodic(Duration(seconds: 1), ((Timer timer) {
        if (timeleft > 0) {
          setState(() {
            timeleft--;
            if (percentage > 0.1) {
              percentage = percentage - perk;
            }
          });
        } else {
          setState(() {
            percentage = 0;
            timeleft = 0;
            _mytimer!.cancel();
          });
        }
      }));
    } else {
      _mytimer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_hunt[0],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                circleoftime(),
                SizedBox(
                  height: 20,
                ),
                rowofclocks()
              ],
            ),
          ),
        ),
      ),
    );
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  Widget pausetheclock() {
    return GestureDetector(
      onTap: () {
        stopped = true;
        _countodown();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: color_hunt[1], borderRadius: BorderRadius.circular(100)),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('Assets/pause.png'),
          )
        ],
      ),
    );
  }

  Widget runtheclock() {
    return GestureDetector(
      onTap: () {
        stopped = false;
        _countodown();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: color_hunt[1], borderRadius: BorderRadius.circular(100)),
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('Assets/play.png'),
          )
        ],
      ),
    );
  }

  Widget circleoftime() {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 110,
          lineWidth: 40,
          percent: percentage,
          progressColor: color_hunt[3],
          backgroundColor: color_hunt[1],
          center: Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: color_hunt[2], borderRadius: BorderRadius.circular(100)),
            child: Text(formatedTime(timeInSecond: timeleft),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'MS Gothic',
                    color: Colors.white)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pausetheclock(),
            SizedBox(
              width: 5,
            ),
            runtheclock()
          ],
        )
      ],
    );
  }

  Widget rowofclocks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTapUp: (details) {
              countclicks++;
              setState(() {
                _mytimer = null;
              });
              percentage = 1;
              timeleft = 5 * 60;
              perk = 1 / (5 * 60);
              _countodown();
            },
            child: timermaker("05:00")),
        GestureDetector(
            onTapUp: (details) {
              countclicks++;
              setState(() {
                _mytimer = null;
              });
              percentage = 1;
              timeleft = 10 * 60;
              perk = 1 / (10 * 60);

              _countodown();
            },
            child: timermaker("10:00")),
        GestureDetector(
            onTapUp: (details) {
              countclicks++;
              setState(() {
                _mytimer = null;
              });

              percentage = 1;
              timeleft = 25 * 60;
              perk = 1 / (25 * 60);

              _countodown();
            },
            child: timermaker("25:00"))
      ],
    );
  }

  Widget timermaker(String time) {
    return Container(
      alignment: Alignment.center,
      height: 90,
      width: 90,
      decoration: BoxDecoration(
          color: color_hunt[1],
          borderRadius: BorderRadiusDirectional.circular(50)),
      child: Text(
        time,
        style: TextStyle(
            fontSize: 28, fontFamily: 'MS Gothic', color: Colors.white),
      ),
    );
  }
}
