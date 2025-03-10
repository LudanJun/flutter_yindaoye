import 'package:flutter/material.dart';

class SegmentPage extends StatefulWidget {
  const SegmentPage({super.key});

  @override
  State<SegmentPage> createState() => _SegmentPageState();
}

class _SegmentPageState extends State<SegmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        title: Text("下拉菜单"),
        //配置滑动导航栏
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
      body: TabBarView(
        //也要配置_tabController
        controller: _tabController,
        children: [
          ListView(
            children: const [
              ListTile(
                title: Text("我是关注列表"),
              )
            ],
          ),
          ListView(
            children: const [
              ListTile(
                title: Text("我是热门列表"),
              )
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
    );
  }
}
