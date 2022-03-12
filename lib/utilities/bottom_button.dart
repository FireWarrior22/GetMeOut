import 'package:flutter/material.dart';
import 'dart:async';
import 'middle_button.dart';

class BottomButton extends StatefulWidget {
  final String name;
  final String number;
  BottomButton({required this.name, required this.number});
  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton>
    with TickerProviderStateMixin {
  late Timer _incomingCallTimer;
  int _incomingCallDuration = 30;
  late AnimationController _controller;
  bool _visibleAnimation = true;
  double _buttonPosition = 0.0;

  void startTimer() {
    _incomingCallTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_incomingCallDuration < 1) {
          _incomingCallTimer.cancel();
          Navigator.pop(context);
        } else {
          _incomingCallDuration = _incomingCallDuration - 1;
          // print(incomingCallDuration);
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _incomingCallTimer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.bottomCenter,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              const SizedBox(
                height: 150,
                width: 100,
              ),
              GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    _visibleAnimation = false;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    _buttonPosition =
                        details.localPosition.dy.clamp(-100.0, 0.0);
                  });
                  // print(buttonPosition);
                },
                onPanEnd: (details) {
                  setState(() {
                    if (_buttonPosition == -100.0) {
                      Navigator.popAndPushNamed(context, '/CallerScreen',
                          arguments: {
                            'name': widget.name,
                          });
                    } else {
                      _buttonPosition = 0.0;
                      _visibleAnimation = true;
                      Navigator.pop(context);
                    }
                  });
                },
                child: Transform.translate(
                  offset: Offset(0.0, _buttonPosition),
                  child: Stack(
                    children: <Widget>[
                      Visibility(
                        visible: _visibleAnimation == false,
                        child: MiddleButton(),
                      ),
                      Visibility(
                        visible: _visibleAnimation == true,
                        child: AnimatedMiddleButton(
                          controller: _controller,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
