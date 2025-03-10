import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/choeseFood/product.dart';
import 'package:flutter_yindaoye/choeseFood/product_model.dart';

class LeftRightMenuPage extends StatefulWidget {
  const LeftRightMenuPage({super.key});

  @override
  State<LeftRightMenuPage> createState() => _LeftRightMenuPageState();
}

class _LeftRightMenuPageState extends State<LeftRightMenuPage> {
  // 左边激活的index
  int _leftSelectedIndex = 0;
  // 左边类目数据
  var leftmenu = ['小吃', '甜品', '荤菜', '素菜', '汤羹'];

  /// 初始化右边商品列表 模型
  ProductModel model = ProductModel.init();

  //定义一个购物车数组 -+都在里面执行
  List<Product> currentModelList = <Product>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('点菜'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              print('去购物车');
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),

      //最外层
      //用row包裹 然后左右按比例分开
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Color.fromRGBO(245, 245, 245, 1),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: leftmenu.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: BoxDecoration(
                        color: _leftSelectedIndex == index
                            ? Colors.white
                            : Color.fromRGBO(245, 245, 245, 1),
                        border: _leftSelectedIndex == index
                            ? Border(
                                left: BorderSide(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              )
                            : Border(left: BorderSide.none),
                      ),
                      child: Text(
                        leftmenu[index],
                        style: TextStyle(
                          color: _leftSelectedIndex == index
                              ? Colors.black
                              : Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        //点击左边列表
                        _leftSelectedIndex = index;
                        //请求右边数据
                      });
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                  itemCount: model.list.length,
                  itemBuilder: (context, index) {
                    return _rightFoodList(
                      model.list[index],
                      model.list[index].count,
                      model.list[index].name,
                      model.list[index].desc,
                      model.list[index].price,
                      model.list[index].imageUrl,
                      model.list[index].tag1,
                      model.list[index].tag2,
                      model.list[index].tag3,
                      model.list[index].saleNum,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rightFoodList(
    var value,
    int count,
    String? name,
    String? desc,
    int? price,
    String? imageUrl,
    String? tag1,
    String? tag2,
    String? tag3,
    int? saleNum, //月销数量
  ) {
    return Container(
      alignment: Alignment.topLeft,
      height: 175,
      padding: EdgeInsets.all(
        15,
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Container(
        //容器里的内容从顶部左开始对齐
        alignment: Alignment.topLeft,
        child: Flex(
          //从左往右对齐
          crossAxisAlignment: CrossAxisAlignment.start,
          //水平排列
          direction: Axis.horizontal,
          children: [
            //右边 左侧 图片 控件
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 月销
                    Text(
                      name!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '月售$saleNum',
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // 简介
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 30,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(255, 250, 205, 1),
                          ),
                          child: const Text(
                            "简介",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 165, 0, 1),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8),
                          width: 150,
                          child: Text(
                            //文本最后显示不下用省略号代替
                            desc!, overflow: TextOverflow.ellipsis,
                            //最多显示一行
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    //钱 控件
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              const Text(
                                '¥',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                price.toString(),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 23,
                                ),
                              )
                            ],
                          ),
                        ),

                        //减 数量 加 控件
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Offstage(
                                //是否隐藏 如果是0 隐藏
                                offstage: count == 0 ? true : false,
                                child: IconButton(
                                  onPressed: () {
                                    if (value.count > 0) {
                                      setState(() {
                                        value.count -= 1;
                                        currentModelList.remove(value);
                                        print("减:${value.count}");
                                        print("减 ${currentModelList}");
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                              ),
                              Offstage(
                                offstage: count == 0 ? true : false,
                                child: Container(
                                  width: 30,
                                  child: Text(
                                    count.toString(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  padding: EdgeInsets.all(0.0),
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Color.fromRGBO(255, 165, 0, 1),
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    print(value);
                                    setState(() {
                                      value.count += 1;
                                      currentModelList.add(value);
                                      print("加:${value.count}");
                                      print("加 ${currentModelList}");
                                    });
                                    // 把数据加入到本地存储
                                    // LocalStorage.addLocalStorage(value, 'add');
                                    // Fluttertoast.showToast(
                                    //     msg: "添加成功！菜品已在购物车中等待",
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.CENTER,
                                    //     timeInSecForIosWeb: 1,
                                    //     backgroundColor: Colors.black54,
                                    //     textColor: Colors.white,
                                    //     fontSize: 16.0);
                                  }),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
