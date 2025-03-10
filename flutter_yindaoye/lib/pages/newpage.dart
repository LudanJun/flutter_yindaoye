import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/segment.dart';

class newPage extends StatelessWidget {
  const newPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("导航"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/videoplayer");
              },
              child: Text("video_player使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/chewie_video_player");
              },
              child: Text("ChewieVideoPage使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/imagePicker");
              },
              child: Text("ImagePickerPage使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/testMenuPage");
              },
              child: Text("TestMenuPage使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/list_menu");
              },
              child: Text("list_menu使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/LeftRightMenuPage");
              },
              child: Text("LeftRightMenuPage使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/DropdownMenuPage");
              },
              child: Text("下拉菜单的使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/SegmentPage");
              },
              child: Text("SegmentPage使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/CartViewPage");
              },
              child: Text("CartViewPage使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/SliverPage");
              },
              child: Text("sliver多个滚动控件使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/NestedScrollPage");
              },
              child: Text("NestedScrollPage多个滚动控件随着滚动使用"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/NinePicPage");
              },
              child: Text("NinePicPage九图显示"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/VoicePage");
              },
              child: Text("语音展示"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/NestedHeadGundongPage");
              },
              child: Text("NestedHeadGundongPage"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/NestedHeadPullPage");
              },
              child: Text("NestedHeadPullPage下拉刷新"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/ScrollorheadgudingPage");
              },
              child: Text("Scrollor中间头部固定"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/ScrollToTopPage");
              },
              child: Text("ScrollToTopPage"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/TextfieldPage");
              },
              child: Text("TextfieldPage"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击购物车图标跳转到购物车页面
                Navigator.of(context).pushNamed("/MeditKitPage");
              },
              child: Text("MeditKitPage"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击单选
                Navigator.of(context).pushNamed("/ChoeseDanxuanPage");
              },
              child: Text("ChoeseDanxuanPage"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 点击单选
                Navigator.of(context).pushNamed("/Pageviewpage");
              },
              child: Text("Pageviewpage"),
            ),
            ElevatedButton(
              onPressed: () {
                /// 轮播图 - 播放图片和shop
                Navigator.of(context).pushNamed("/LunboPhotoVideoPage");
              },
              child: Text("LunboPhotoVideoPage"),
            ),
          ],
        ),
      ),
    );
  }
}
