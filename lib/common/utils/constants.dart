import 'package:flutter/material.dart';

const List<Color> kColors = [
  Color(0xFF01a3a4),
  Color(0xFFff9f43),
  Color(0xFF54a0ff),
  Color(0xFFee5253),
  Color(0xFF5f27cd),
  Color(0xFF0abde3),
  Color(0xFF10ac84),
  Color(0xFF576574),
];

Color getRandomColor(Object obj) {
  final int randomIndex = obj.hashCode % kColors.length;
  return kColors[randomIndex];
}
