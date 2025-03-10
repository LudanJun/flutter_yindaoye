class Product {
  int? id;
  int count = 0; //添加数量
  String? name;
  String? desc;
  int? price;
  String? imageUrl;
  String? tag1;
  String? tag2;
  String? tag3;
  int? saleNum; //月销数量

  Product({
    this.id,
    required this.count,
    this.name,
    this.desc,
    this.price,
    this.imageUrl,
    this.tag1,
    this.tag2,
    this.tag3,
    this.saleNum,
  });
}
