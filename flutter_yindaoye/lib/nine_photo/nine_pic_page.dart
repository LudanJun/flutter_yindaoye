import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_yindaoye/nine_photo/generateData.dart';

class NinePicPage extends StatefulWidget {
  const NinePicPage({super.key});

  @override
  State<NinePicPage> createState() => _NinePicPageState();
}

class _NinePicPageState extends State<NinePicPage> {
  final List<String> _photos = [];

  //加载生成的图片数据
  bool _onLoadData({int count = 0}) {
    final gData = Generatedata();
    int myCount = count == 0 ? gData.generateNum(9, 0) : count;
    _photos.clear();
    for (int i = 0; i < myCount; i++) {
      _photos.add(gData.buildGallary());
    }
    return true;
  }

  //调用照片库
  void _callPhotosGallery(int index) {
    List<AssetImage> images = [];
    //获取本地/网络图片数据
    for (String img in _photos) {
      images.add(AssetImage(img));
    }
    //初始化多图状态
    MultiImageProvider multiImageProvider =
        MultiImageProvider(images, initialIndex: index);
    //显示图片
    showImageViewerPager(
      context,
      multiImageProvider, //传入图片数据
      swipeDismissible: true, //向下滑动关闭
      doubleTapZoomable: true, //双击缩放
      onPageChanged: (page) {
        print("page changed to $page");
      },
      onViewerDismissed: (page) {
        print("dismissed while on page $page");
      },
      infinitelyScrollable: true,//连续滚动浏览
    );
  }

  @override
  void initState() {
    super.initState();
    _onLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _uiHeadert(),
      body: _uiBody(),
      floatingActionButton: _uiFloating(),
    );
  }

  AppBar _uiHeadert() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Wechat-PhotosGallery-Demo"),
    );
  }

  Widget _uiBody() {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(8),
      child: _uiBodyPhotos(),
    );
  }

  Widget _uiBodyPhotos() {
    List<StaggeredGridTile> titles = [];
    for (var i = 0; i < _photos.length; i++) {
      final title = _uiBodyPhotosTitle(i);
      titles.add(title);
    }
    if (titles.isEmpty) {
      return Container();
    }
    int corseCount = titles.length >= 2 ? 3 : titles.length;
    corseCount = titles.length < 2 ? 2 : corseCount;
    return StaggeredGrid.count(
      crossAxisCount: corseCount,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: titles,
    );
  }

  StaggeredGridTile _uiBodyPhotosTitle(int index) {
    //相片
    final img = Image.asset(
      _photos.elementAt(index),
      fit: BoxFit.cover,
      width: double.maxFinite,
      height: double.maxFinite,
    );
    //相框装上相片
    final frame = InkWell(
      onTap: () => _callPhotosGallery(index),
      child: img,
    );
    return StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: frame,
    );
  }

  Widget _uiFloating() {
    final random = FilledButton(
      onPressed: () {
        _onLoadData();
        setState(() {});
      },
      child: const Text("Random"),
    );
    final random1 = FilledButton(
      onPressed: () {
        _onLoadData(count: 1);
        setState(() {});
      },
      child: const Text("1"),
    );
    final random2 = FilledButton(
      onPressed: () {
        _onLoadData(count: 2);
        setState(() {});
      },
      child: const Text("2"),
    );
    final random3 = FilledButton(
      onPressed: () {
        _onLoadData(count: 3);
        setState(() {});
      },
      child: const Text("3"),
    );

    final layout = Row(
      children: [random, random1, random2, random3],
    );
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(20),
      child: layout,
    );
  }
}
