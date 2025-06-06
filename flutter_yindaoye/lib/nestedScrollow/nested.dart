import 'package:flutter/material.dart';

class NestedScrollPage extends StatefulWidget {
  const NestedScrollPage({super.key});

  @override
  State<NestedScrollPage> createState() => _NestedScrollPageState();
}

class _NestedScrollPageState extends State<NestedScrollPage> {
  final List<String> _tabs = const ['tab1', 'tab2', 'tab3', 'tab4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //1.DefaultTabController 是不需要提供传入controller,如需要检测滚动来改变导航
      //则不需要DefaultTabController嵌套,需要定义一个scrollerController 来使用
      body: DefaultTabController(
        length: _tabs.length,
        //2.可可以控制滚动
        child: NestedScrollView(
          //头部固件
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              _buildHeader(context, innerBoxIsScrolled),
            ];
          },
          //内容
          body: _buildTabBarView(),
        ),
      ),
    );
  }

// 头部
  Widget _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return // SliverOverlapAbsorber 的作用是处理重叠滚动效果，
        // 防止 CustomScrollView 中的滚动视图与其他视图重叠。
        SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver:
          // SliverAppBar 的作用是创建可折叠的顶部应用程序栏，
          // 它可以随着滚动而滑动或固定在屏幕顶部，并且可以与其他 Sliver 小部件一起使用。
          SliverAppBar(
        title: const Text('滚动一致性'),
        //该属性用来固定tabbar
        pinned: true,
        elevation: 6, //影深
        expandedHeight: 300.0,
        forceElevated: innerBoxIsScrolled, //为true时展开有阴影
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            "assets/images/banner-bg.jpg",
            fit: BoxFit.cover,
          ),
        ),

        // 底部固定栏
        bottom: MyCustomAppBar(
          child: Column(
            children: [
              Container(
                color: Colors.greenAccent,
                child: const Center(child: Text('固定高度内容')),
              ),
              TabBar(
                tabs: _tabs
                    .map(
                      (String name) => Tab(
                        text: name,
                      ),
                    )
                    .toList(),
              ),
              Container(
                color: Colors.orange,
                child: const Center(child: Text('固定高度内容')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      children: _tabs.map((String name) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(name),
                slivers: <Widget>[
                  // SliverOverlapInjector 的作用是处理重叠滚动效果，
                  // 确保 CustomScrollView 中的滚动视图不会与其他视图重叠。
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),

                  // 横向滚动
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                      child: PageView(
                        children: [
                          Container(
                            color: Colors.yellow,
                            child: const Center(child: Text('横向滚动')),
                          ),
                          Container(color: Colors.green),
                          Container(color: Colors.blue),
                        ],
                      ),
                    ),
                  ),

                  // 固定高度内容
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      color: Colors.greenAccent,
                      child: const Center(child: Text('固定高度内容')),
                    ),
                  ),

                  // 列表
                  buildContent(name),

                  // 固定高度内容
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      color: Colors.greenAccent,
                      child: const Center(child: Text('固定高度内容')),
                    ),
                  ),

                  // 列表 100 行
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(title: Text('Item $index'));
                      },
                      childCount: 100,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }).toList(),
    );
  }

  // 内容列表
  Widget buildContent(String name) => SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverFixedExtentList(
          itemExtent: 48.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: Text('$name - $index'),
              );
            },
            childCount: 50,
          ),
        ),
      );
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  const MyCustomAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 40.0);
}
