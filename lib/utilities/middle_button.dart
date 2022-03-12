import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArrowStack extends StatefulWidget {
  final AnimationController controller;

  ArrowStack({required this.controller});

  @override
  _ArrowStackState createState() => _ArrowStackState();
}

class _ArrowStackState extends State<ArrowStack> {
  late Animation<double> _colorTween;

  @override
  void initState() {
    _colorTween = Tween(
      begin: 3.0,
      end: -3.0,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0, 0.5),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      child: ShaderMask(
        shaderCallback: (rect) {
          return RadialGradient(
            center: Alignment(0, _colorTween.value),
            radius: 1,
            colors: const [
              Colors.black,
              Color(0xFF1F2831),
            ],
            // tileMode: TileMode.mirror,
          ).createShader(rect);
        },
      ),
    );
  }
}

//* ANIMATED MIDDLE BUTTON

class AnimatedMiddleButton extends StatefulWidget {
  final AnimationController controller;

  AnimatedMiddleButton({required this.controller});

  @override
  _AnimatedMiddleButtonState createState() => _AnimatedMiddleButtonState();
}

class _AnimatedMiddleButtonState extends State<AnimatedMiddleButton> {
  @override
  Widget build(BuildContext context) {
    return StaggerAnimation(
      controller: widget.controller.view,
    );
  }
}

//* MIDDLE BUTTON

class MiddleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF02D65D),
      ),
      constraints: const BoxConstraints.tightFor(
        width: 66,
        height: 66,
      ),
      child: const Icon(
        Icons.call,
        size: 28,
        color: Colors.white,
      ),
    );
  }
}

//* Shake Curve

class ShakeCurve extends Curve {
  final double _begin;
  final double _end;

  ShakeCurve(this._begin, this._end);

  @override
  double transformInternal(double t) {
    t = ((t - _begin) / (_end - _begin)).clamp(0.0, 1.0);
    var val = (0.1 / 0.8 + t) * math.sin((2 * math.pi * t) / 0.4) + 0.5;
    // var val = math.sin(3 * 2 * math.pi * t) * 0.5 + 0.5;
    return val;
  }
}

//* Stagger Animation

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({required this.controller})
      : _moveUp = Matrix4Tween(
          begin: Matrix4.translationValues(0, 0, 0),
          end: Matrix4.translationValues(0, -20, 0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.25),
          ),
        ),
        _moveDown = Tween<double>(
          begin: 0,
          end: 30,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.35, 0.5),
          ),
        ),
        _shake = Tween<double>(
          begin: -2,
          end: 2,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: ShakeCurve(0.25, 0.35),
          ),
        );

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      transform: _moveUp.value,
      child: Container(
        transform: Matrix4.translationValues(
          _shake.value,
          _moveDown.value,
          0,
        ),
        child: MiddleButton(),
      ),
    );
  }

  final Animation<double> controller;
  final Animation _moveUp;
  final Animation _moveDown;
  final Animation _shake;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}
