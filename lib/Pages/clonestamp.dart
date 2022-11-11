import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

void main() => runApp(MaterialApp(home: CountdownCard()));

class CountdownCard extends StatefulWidget {
// This widget is the root of your application.

  @override
  _CountdownCardState createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  Timer? _timer;
  int _start = 0;
  bool _vibrationActive = false;

  void startTimer(int timerDuration) {
    if (_timer != null) {
      _timer!.cancel();
      cancelVibrate();
    }
    setState(() {
      _start = timerDuration;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            vibrate();
          } else {
            _start = _start - 1;
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
        appBar: AppBar(
          title: Text('Countdown'),
        ),
        body: Wrap(children: <Widget>[
          Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  startTimer(10);
                },
                child: Text("start"),
              ),
              Text("$_start"),
              ElevatedButton(
                onPressed: () {
                  pauseTimer();
                },
                child: Text("pause"),
              ),
              ElevatedButton(
                onPressed: () {
                  unpauseTimer();
                },
                child: Text("unpause"),
              ),
              ElevatedButton(
                onPressed: () {
                  cancelVibrate();
                },
                child: Text("stop alarm"),
              ),
            ],
          ),
        ]));
  }
}
