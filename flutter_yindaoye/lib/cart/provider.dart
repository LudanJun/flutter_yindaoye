import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/cart/listData.dart';

class CartVProvider extends ChangeNotifier {
  bool checkAllBox = false;

  //是否全选
  checkAllBoxFunc(bool value) {
    checkAllBox = value;
    notifyListeners();
  }

  List _list = [];
  List get list => _list;

  //添加单个数据
  add(Map<String, dynamic> map) {
    _list.add(map);
    notifyListeners();
  }

  //移除单个
  remove(Map<String, dynamic> map) {
    _list.remove(map);
    notifyListeners();
  }
  //添加所有

  //移除所有
  //移除所有
  removeAll(List list) {
    _list.clear();
    notifyListeners();
  }
}
