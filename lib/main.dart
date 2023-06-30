// ignore_for_file: prefer_const_constructors
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounterDownApp(),
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({Key? key}) : super(key: key);

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);

  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (qqqqqq) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pomodoro App ",
          style: TextStyle(fontSize: 26, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(149, 112, 26, 250),
      ),
      backgroundColor: Color.fromARGB(255, 33, 31, 37),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 140,
                lineWidth: 10.0,
                progressColor: Color.fromARGB(255, 130, 9, 166),
                backgroundColor: Colors.white,
                percent: duration.inMinutes / 25,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1000,
                center: Text(
                  "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")} ",
                  style: TextStyle(
                    fontSize: 77,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 55,
          ),
          isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else {
                          startTimer();
                        }
                      },
                      child: Text(
                        (repeatedFunction!.isActive) ? "Stop" : "Resume",
                        style: TextStyle(fontSize: 22),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 197, 25, 97)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repeatedFunction!.cancel();
                        setState(() {
                          duration = Duration(minutes: 25);
                          isRunning = false;
                        });
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 197, 25, 97)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: Text(
                    "Start Studying",
                    style: TextStyle(fontSize: 23),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 27, 175, 170)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                )
        ],
      ),
    );
  }
}
