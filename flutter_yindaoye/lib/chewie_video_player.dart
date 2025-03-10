import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ChewieVideoPage extends StatefulWidget {
  const ChewieVideoPage({super.key});

  @override
  State<ChewieVideoPage> createState() => _ChewieVideoPageState();
}

class _ChewieVideoPageState extends State<ChewieVideoPage> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    super.initState();

    //1.在这里初始化
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

    //2.配置chewie
    //要想改这个播放器进度条的颜色需要改主题色
    //   theme: ThemeData(
    //   primarySwatch: Colors.blue,
    // ),
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      //配置视频宽高比
      aspectRatio: 3 / 2,
      //自动播放
      autoPlay: true,
      //循环播放
      looping: true,
      // subtitle: Subtitles([
      //   Subtitle(
      //     index: 0,
      //     start: Duration.zero, //多少秒开始
      //     end: const Duration(seconds: 3), //多少秒结束
      //     text: 'Hello from subtitles',
      //   ),
      //   Subtitle(
      //     index: 1,
      //     start: const Duration(seconds: 4),
      //     end: const Duration(seconds: 5),
      //     text: 'Whats up? :)',
      //   ),
      // ]),
      //如果上面配置了subtitle 这里的defaultOptions就不是播放进度了
      optionsBuilder: (context, defaultOptions) async {
        await showModalBottomSheet(
            context: context,
            builder: (context) {
              return ListView(
                //这播放进度汉化针对安卓有效 iOS只显示速度选项
                children: [
                  ListTile(
                    title: Text("播放速度"),
                    onTap: () {
                      defaultOptions[0].onTap!();
                    },
                  ),
                  ListTile(
                    title: const Text("取消"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //记得销毁两个播放器
    videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("在线视频播放"),
      ),
      body: Center(
          //想要控制视频大小在外层套一个AspectRatio
          child: AspectRatio(
        aspectRatio: 3 / 2,
        //添加chewie播放器
        child: Chewie(
          controller: chewieController,
        ),
      )),
    );
  }
}
