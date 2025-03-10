import 'package:flutter_yindaoye/choeseFood/product.dart';

class ProductModel {
  List<Product> list = <Product>[];

  //初始化循环创建20个商品

  ProductModel.init() {
    for (var i = 0; i < 10; i++) {
      var product = Product(
        id: i,
        count: 0,
        name: "酸菜鱼",
        desc: "川菜必点必吃!!!!!!!!!!!!!!!!!!!!!!!!!",
        price: 5 + i,
        imageUrl:
            "https://attachment4.jmw.com.cn/image/2019/03/01/15514261568182.jpg",
        tag1: "酸辣",
        tag2: "新鲜",
        tag3: "爽口",
        saleNum: i,
      );
      list.add(product);
    }
  }
}