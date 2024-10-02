import 'package:flutter/material.dart';

class RotatingIcon extends StatefulWidget {
  const RotatingIcon({Key? key}) : super(key: key);

  @override
  _RotatingIconState createState() => _RotatingIconState();
}

class _RotatingIconState extends State<RotatingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duration of one rotation
      vsync: this,
    )..repeat(); // Repeats the rotation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: const Icon(
        Icons.auto_awesome, // Robot icon
        size: 50,
        color: Colors.blue,
      ),
    );
  }
}