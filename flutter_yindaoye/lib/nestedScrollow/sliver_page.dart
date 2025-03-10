import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SliverPage extends StatefulWidget {
  const SliverPage({super.key});

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _subtabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose(); //释放内存
  }

  //创建滑动到顶部的固定栏位
  Widget _buildPersistentHeader(Widget child,
          {double? minHeight, double? maxHeight}) =>
      SliverPersistentHeader(
          pinned: true, //这个属性很关键 决定 固不固定
          delegate: _SliverDelegate(
              //需要实现一个_SliverDelegate代理 ,需要抽象类来实现代理
              minHeight: minHeight ?? 40.0,
              maxHeight: maxHeight ?? 40.0,
              child: child));

  Widget _mainView() {
    return CustomScrollView(
      slivers: [
        //1.横向滚动
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: PageView(
              children: [
                Container(
                  color: Colors.yellow,
                  child: const Center(
                    child: Text("横向滚动"),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text("横向滚动"),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text("横向滚动"),
                  ),
                ),
              ],
            ),
          ),
        ),
        //2.固定高度
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.greenAccent,
            child: const Center(
              child: Text("固定高度内容"),
            ),
          ),
        ),
        //3.创建一个固定的tabbar
        SliverToBoxAdapter(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      text: 'Tab 1',
                    ),
                    Tab(
                      text: 'Tab 1',
                    ),
                    Tab(
                      text: 'Tab 1',
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: TabBarView(
                    children: [
                      Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return Container(
                                color: generateRandomColor(),
                                height: 200,
                              );
                            }),
                      ),
                      Container(
                        color: Colors.orange,
                      ),
                      Container(
                        color: Colors.blue,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        //4.创建一个可以滚到顶部固定不动的 Tabbar 固定
        _buildPersistentHeader(
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Tab 1',
              ),
              Tab(
                text: 'Tab 2',
              ),
              Tab(
                text: 'Tab 3',
              ),
            ],
          ),
        ),
        //子 TabBar 固定
        _buildPersistentHeader(
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'subTab 1',
              ),
              Tab(
                text: 'subTab 2',
              ),
              Tab(
                text: 'subTab 3',
              ),
            ],
          ),
        ),
        //TabBarView自适应高度 自动撑开高度不用计算高度 不使用会报错
        SliverFillRemaining(
          child: TabBarView(
            controller: _tabController,
            children: [
              //第一个选项卡
              ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
              //第二个选项卡
              ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
              //第三个选项卡
              ListView.builder(
                itemCount: 25,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            color: Colors.greenAccent,
            child: const Center(
              child: Text("固定高度内容"),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                title: Text("Item $index"),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }

  Color generateRandomColor() {
    return Color.fromARGB(
      255, // 不透明度（0到255）
      Random().nextInt(255), // 红色（0到255）
      Random().nextInt(255), // 绿色（0到255）
      Random().nextInt(255), // 蓝色（0到255）
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("多个滚动控件嵌套"),
      ),
      body: _mainView(),
    );
  }
}

class _SliverDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child;

  _SliverDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});
  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override //是否需要重建
  bool shouldRebuild(_SliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
