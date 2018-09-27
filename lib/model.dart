import 'package:flutter/material.dart';

class Lane {
  final Color boxColor;
  final double speed;
  final List<double> boxwidths;
  final bool forward;
  final bool empty;

  Lane({
    this.boxColor= Colors.transparent,
    this.speed = 1.0,
    this.boxwidths = const [],
    this.forward = true,
    this.empty = false
  });

}

final List<Lane> lanes = [
  Lane(
      boxColor: Colors.lightGreen,
      speed: 0.0,
      boxwidths:  [],
      forward: false,
      empty: true,
  ),
  Lane(
      boxColor: Colors.white,
      speed: 0.4,
      boxwidths:  [100.0, 300.0],
      forward: true
  ),
  Lane(
    boxwidths:  [],
    forward: false,
    empty: true,
  ),
  Lane(
      boxColor: Colors.brown,
      speed: 0.6,
      boxwidths:  [100.0, 100.0, 100.0],
      forward: false
  ),
  Lane(
    boxwidths:  [],
    forward: false,
    empty: true,
  ),
  Lane(
      boxColor: Colors.yellow,
      speed: 0.8,
      boxwidths:  [100.0, 100.0, 200.0],
      forward: true
  ),
  Lane(
      boxColor: Colors.pink,
      speed: 0.2,
      boxwidths:  [200.0, 50.0, 200.0],
      forward: false
  ),
  Lane(
      boxColor: Colors.white,
      speed: 0.6,
      boxwidths:  [200.0, 200.0],
      forward: false
  ),
];