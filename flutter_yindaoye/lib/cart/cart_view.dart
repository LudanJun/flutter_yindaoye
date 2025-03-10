import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/cart/provider.dart';
import 'package:flutter_yindaoye/cart/listData.dart';
import 'package:provider/provider.dart';

class CartViewPage extends StatefulWidget {
  const CartViewPage({super.key});

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  CartVProvider _cartVProvider = CartVProvider();
  //生命周期函数:当组件初始化的时候就会触发
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("喜好选择"),
        bottom: TabBar(
          isScrollable: false, //是否可以滚动
          indicatorColor: Colors.black, //指示器颜色
          indicatorWeight: 2, //指示器高度
          // indicatorPadding:const EdgeInsets.all(5),//上下左右5个间距
          indicatorSize: TabBarIndicatorSize.label, //跟文字一样长
          // indicator: BoxDecoration(//不常用
          //   //指示器边框设置
          //   color: Colors.red,
          //   //配置圆角
          //   borderRadius: BorderRadius.circular(10),
          // ),
          labelColor: Colors.black, //选中label后的文字颜色
          labelStyle: const TextStyle(fontSize: 20 //选中的文字大小
              ),
          // unselectedLabelColor: Colors.white,//未选中的文字颜色
          unselectedLabelStyle: const TextStyle(
            fontSize: 15, //未选中文字大小
          ),
          controller: _tabController, //注意:配置controller需要去掉TabBar的cost属性
          onTap: (value) {
            print(value);
          },
          tabs: const [
            Tab(
              child: Text("关注"),
            ),
            Tab(
              child: Text("热门"),
            ),
            Tab(
              child: Text("视频"),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            //也要配置_tabController
            controller: _tabController,
            children: [
              Stack(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2, //横轴水平间距
                      crossAxisCount: 3, //配置一行有几个
                      mainAxisSpacing: 5, //垂直间距
                      childAspectRatio: 2 / 3, //宽高比
                    ),
                    itemCount: listData.length,
                    itemBuilder: _initGridViewData,
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      width: 1080,
                      height: 90,
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: Color.fromARGB(211, 240, 236, 236),
                                width: 2),
                          ),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),

              // ListView(
              //   children: const [
              //     ListTile(
              //       title: Text("我是关注列表"),
              //     )
              //   ],
              // ),
              ListView(
                children: const [
                  ListTile(
                    title: Text("我是热门列表"),
                  ),
                ],
              ),
              ListView(
                children: const [
                  ListTile(
                    title: Text("我是视频列表"),
                  )
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.only(right: 20),
              width: 1080,
              height: 90,
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(211, 240, 236, 236), width: 2),
                  ),
                  color: Colors.orange),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: Provider.of<CartVProvider>(context, listen: true)
                            .checkAllBox,
                        onChanged: (value) {
                          print(value);
                          Provider.of<CartVProvider>(context, listen: false)
                              .checkAllBoxFunc(value!);

                          Provider.of<CartVProvider>(context, listen: false)
                              .removeAll(listData);
                        },
                      ),
                      Text('全选'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _initGridViewData(context, index) {
    //通过这个方式来判断商品是否在购物车里面
    bool isInCart = Provider.of<CartVProvider>(context)
        .list
        .any((element) => element == listData[index]);
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black26,
      )),
      child: Column(
        children: [
          Image.network(listData[index]["imageUrl"]),
          const SizedBox(height: 10),
          Text(
            listData[index]["title"],
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print(index);
              if (isInCart) {
                //从购物车移除数据
                Provider.of<CartVProvider>(context, listen: false)
                    .remove(listData[index]);
              } else {
                //给购物车添加数据
                Provider.of<CartVProvider>(context, listen: false)
                    .add(listData[index]);
              }
            },
            child: isInCart ? Text("已关注") : Text("关注"),
          ),
        ],
      ),
    );
  }
}
