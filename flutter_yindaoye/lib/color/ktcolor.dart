import 'dart:math';

import 'package:flutter/material.dart';

class KTColor {
  //获取随机颜色
  static Color getRandomColor() {
    return Color.fromARGB(
      255,
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
      Random.secure().nextInt(200),
    );
  }
}
