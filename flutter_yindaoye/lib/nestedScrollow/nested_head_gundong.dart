import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/color/ktcolor.dart';
import 'package:loading_more_list/loading_more_list.dart';

//头部可以跟着滚动
class NestedHeadGundongPage extends StatefulWidget {
  const NestedHeadGundongPage({super.key});

  @override
  State<NestedHeadGundongPage> createState() => _NestedHeadGundongPageState();
}

class _NestedHeadGundongPageState extends State<NestedHeadGundongPage>
    with TickerProviderStateMixin {
  // ScrollController创建滚动控制器才能用来监听滚动视图滚动的状态
  // final ScrollController _tab1ScrollController = ScrollController();

  late final TabController primaryTC; //初级tabC
  late final TabController secondaryTC;

  final List<String> _tabs = const ['Tab0', 'Tab1'];
  int _visibleItemIndex = -1;

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: _tabs.length, vsync: this);
    secondaryTC = TabController(length: 5, vsync: this);
    /*
    _tab1ScrollController.addListener(() {
      double offset = _tab1ScrollController.offset;
      //item高度 60
      double itemHeight = 500.0;
      //计算当前屏幕中间的item索引
      int itemIndex = (offset / itemHeight).round() + 1;
      print("itemIndex - $itemIndex");

      if (itemIndex != _visibleItemIndex) {
        setState(() {
          _visibleItemIndex = itemIndex;
          // 可以在这里触发动画或其他逻辑
          print("播放第$_visibleItemIndex个视频");
        });
      }
    });*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    primaryTC.dispose();
    // _tab1ScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: _buidScaffoldBody(),
      ),

      //  _buidScaffoldBody(),
    );
  }

  // 模拟刷新操作的异步函数
  Future<void> _handleRefresh() async {
    return Future.delayed(Duration(seconds: 2)).then((_) {
      print("下拉刷新了");
      // 刷新完成后，你可能需要更新状态并通知UI刷新
      // 这通常涉及到调用setState()如果你的上下文是StatefulWidget
      // 或者如果你使用setStatelessWidget，你可能需要使用其他状态管理方式
    });
  }

  Widget _buidScaffoldBody() {
    //状态栏高度
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    //固定头部的高度
    final double pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    // 因为无法给NestedScrollView的body中的列表设置ScrollController(这样会破坏NestedScrollView内部的InnerScrollController的行为)，
    // 所以我这里给大家提供了Demos来展示怎么不通过ScrollController来完成
    return ExtendedNestedScrollView(
      //添加头部视图
      headerSliverBuilder: (BuildContext context, bool f) {
        return buildSliverHeader();
      },
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      floatHeaderSlivers: true,
      //只有一个滚动体
      onlyOneScrollInBody: true,
      body: Column(
        children: [
          TabBar(
            controller: primaryTC,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            isScrollable: false,
            unselectedLabelColor: Colors.grey,
            tabs: _tabs.map(
              (value) {
                return Tab(
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          Expanded(
            child: TabBarView(
              controller: primaryTC,
              children: [
                SecondaryTabView('Tab0', secondaryTC),
                GlowNotificationWidget(
                  ExtendedVisibilityDetector(
                    child: ListView.builder(
                      key: const PageStorageKey<String>('Tab1'),
                      physics: const ClampingScrollPhysics(),
                      itemCount: 50,
                      itemBuilder: (c, i) {
                        return Container(
                          alignment: Alignment.center,
                          color: KTColor.getRandomColor(),
                          height: 500.0,
                          child: ListTile(
                            title: Text(
                              const Key('Tab1').toString() + ': ListView$i',
                            ),
                            // 根据_visibleItemIndex判断当前item是否在屏幕中间
                            selected: i == _visibleItemIndex,
                          ),
                        );
                      },
                    ),
                    uniqueKey: const Key("Tab1"),
                  ),
                  showGlowLeading: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //添加的是滚动后隐藏的视图
  List<Widget> buildSliverHeader() {
    final List<Widget> widgets = <Widget>[];

    widgets.add(
      SliverAppBar(
        pinned: true,
        title: Row(
          children: [
            Text("哈哈还是"),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.abc_outlined),
            ),
          ],
        ),
        expandedHeight: 200,
        flexibleSpace: FlexibleSpaceBar(
          //折叠方式引脚
          collapseMode: CollapseMode.pin,
          background: Image.asset(
            'images/1.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
    return widgets;
  }
}

class SecondaryTabView extends StatefulWidget {
  const SecondaryTabView(this.tabKey, this.tc);

  final String tabKey;
  final TabController tc;

  @override
  _SecondaryTabViewState createState() => _SecondaryTabViewState();
}

class _SecondaryTabViewState extends State<SecondaryTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final TabBar secondaryTabBar = TabBar(
      controller: widget.tc,
      labelColor: Colors.blue,
      indicatorColor: Colors.blue,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 2.0,
      isScrollable: false,
      unselectedLabelColor: Colors.grey,
      tabs: <Tab>[
        Tab(text: widget.tabKey + '0-'),
        Tab(text: widget.tabKey + '1-'),
        Tab(text: widget.tabKey + '2-'),
        Tab(text: widget.tabKey + '3-'),
        Tab(text: widget.tabKey + '4-'),
      ],
    );
    return Column(
      children: <Widget>[
        secondaryTabBar,
        Expanded(
          child: TabBarView(
            controller: widget.tc,
            children: <Widget>[
              TabViewItem(Key(widget.tabKey + '0@')),
              TabViewItem(Key(widget.tabKey + '1@')),
              TabViewItem(Key(widget.tabKey + '2@')),
              TabViewItem(Key(widget.tabKey + '3@')),
              CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: Container(
                      color: Colors.blue,
                      child: const Text('tab4'),
                      alignment: Alignment.center,
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TabViewItem extends StatefulWidget {
  const TabViewItem(this.tabKey);

  final Key tabKey;

  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Widget child = ExtendedVisibilityDetector(
      uniqueKey: widget.tabKey,
      child: GlowNotificationWidget(
        //margin: EdgeInsets.only(left: 190.0),
        ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext c, int i) {
              return Container(
                //decoration: BoxDecoration(border: Border.all(color: Colors.orange,width: 1.0)),
                alignment: Alignment.center,
                height: 60.0,
                width: double.infinity,
                //color: Colors.blue,
                child: Text(widget.tabKey.toString() + ': List$i'),
              );
            },
            itemCount: 100,
            padding: const EdgeInsets.all(0.0)),
        showGlowLeading: false,
      ),
    );

    return child;
  }

  @override
  bool get wantKeepAlive => true;
}
