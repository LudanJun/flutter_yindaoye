import 'dart:math';

//本地随机生成图片
class Generatedata {
  String buildGallary() {
    return "images/${generateNum(9, 0)}.jpg";
  }

  int generateNum(int max, int min) {
    int result = 0;
    do {
      result = Random().nextInt(max);
    } while (result <= min || result >= max);
    return result;
  }
}
