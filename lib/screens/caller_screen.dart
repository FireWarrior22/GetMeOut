import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class CallerScreen extends StatelessWidget {
  static const routeName = '/CallerScreen';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String name = args['name'];
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(35.0, 70.0, 35.0, 0.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFFECE00),
              radius: 40,
              child: Text(
                name[0],
                style: kHeadingTextStyle.copyWith(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ), //CircleAvatar
            Text(
              args['name'],
              style: kHeadingTextStyle.copyWith(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5.0,
            ),
            TickingTimer(),
            const Expanded(
              child: SizedBox(
                height: 1.0,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe3e5, fontFamily: 'MaterialIcons'),
                        size: 45.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Mute",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe1ce, fontFamily: 'MaterialIcons'),
                        size: 45.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Keypad",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe6c5, fontFamily: 'MaterialIcons'),
                        size: 48.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Speaker",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe04d, fontFamily: 'MaterialIcons'),
                        size: 45.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Add Call",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe47d, fontFamily: 'MaterialIcons'),
                        size: 50.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Hold",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1.0,
                    ),
                  ),
                  Column(
                    children: [
                      const Icon(
                        IconData(0xe503, fontFamily: 'MaterialIcons'),
                        size: 50.0,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Record",
                        style: kLabelTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                IconData(0xe127, fontFamily: 'MaterialIcons'),
                size: 30.0,
              ),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                primary: Colors.red,
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}

class TickingTimer extends StatefulWidget {
  @override
  _TickingTimerState createState() => _TickingTimerState();
}

class _TickingTimerState extends State<TickingTimer> {
  int _intMin = 0;
  int _intSec = 00;
  String _seconds = "00";
  String _minutes = "0";
  late Timer _callTimer;

  void _startTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_intSec < 9) {
        setState(() {
          _intSec++;
          _seconds = "0$_intSec";
        });
      } else if (_intSec == 59) {
        setState(() {
          _intSec = 0;
          _intMin++;
          _seconds = "0$_intSec";
          _minutes = "$_intMin";
        });
      } else {
        setState(() {
          _intSec++;
          _seconds = "$_intSec";
        });
      }
    });
  }

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _callTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$_minutes:$_seconds",
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.black,
      ),
    );
  }
}
