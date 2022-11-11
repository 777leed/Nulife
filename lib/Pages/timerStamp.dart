// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

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
  int _start = 0;
  bool _vibrationActive = false;
  Timer? _timer;
  double percentage = 0;
  double perk = 0;

  void startTimer(int timerDuration) {
    if (_timer != null) {
      _timer!.cancel();
      cancelVibrate();
    }
    setState(() {
      _start = timerDuration;
    });
    const oneSec = Duration(milliseconds: 50);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            vibrate();
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      backgroundColor: color_hunt[2],
                      title: Center(
                        child: Text("YOUR TIME IS DONE HERE",
                            style: TextStyle(
                                fontFamily: 'MS Gothic', color: Colors.white)),
                      ),
                      actions: [
                        Center(
                          child: TextButton(
                              onPressed: () {
                                cancelVibrate();
                                Navigator.of(context).pop();
                              },
                              child: Text("STOP")),
                        )
                      ],
                    ));
          } else {
            _start = _start - 1;
            percentage = percentage - perk;
          }
        },
      ),
    );
  }

  void cancelVibrate() {
    _vibrationActive = false;
    Vibration.cancel();
  }

  void vibrate() async {
    _vibrationActive = true;
    bool? hasvib = await Vibration.hasVibrator();
    if (hasvib!) {
      while (_vibrationActive) {
        Vibration.vibrate(duration: 1000);
        await Future.delayed(Duration(seconds: 2));
      }
    }
  }

  void pauseTimer() {
    if (_timer != null) _timer!.cancel();
  }

  void unpauseTimer() => startTimer(_start);

  @override
  void dispose() {
    _timer!.cancel();
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
        pauseTimer();
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
        unpauseTimer();
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
            child: Text(formatedTime(timeInSecond: _start),
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
              setState(() {
                percentage = 1;
                perk = 1 / 300;
              });

              startTimer(60 * 5);
            },
            child: timermaker("05:00")),
        GestureDetector(
            onTapUp: (details) {
              setState(() {
                percentage = 1;
                perk = 1 / 600;
              });
              startTimer(60 * 10);
            },
            child: timermaker("10:00")),
        GestureDetector(
            onTapUp: (details) {
              setState(() {
                percentage = 1;
                perk = 1 / 1500;
              });
              startTimer(60 * 25);
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
