import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPickerPage extends StatefulWidget {
  const VideoPickerPage({super.key});

  @override
  State<VideoPickerPage> createState() => _VideoPickerPageState();
}

class _VideoPickerPageState extends State<VideoPickerPage> {
  //实例化图片选择器
  final ImagePicker _picker = ImagePicker();
  //定义全局获取的图片属性 来实现显示
  XFile? _pickedFile;

  //配置加载视频
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  //获取完视频后再初始化视频播放器
  _initVideo(fileDir) async {
    //1.在这里初始化 加载本地视频
    videoPlayerController = VideoPlayerController.file(fileDir);

    //调用初始视频化控制器 初始化完后才可以获取视频宽高比了
    await videoPlayerController.initialize();
    //2.配置chewie
    //要想改这个播放器进度条的颜色需要改主题色
    //   theme: ThemeData(
    //   primarySwatch: Colors.blue,
    // ),
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      //配置视频宽高比
      aspectRatio: videoPlayerController.value.aspectRatio,
      //自动播放
      autoPlay: false,
      //循环播放
      looping: true,
    );
  }

  //录制视频
  _pickCameraVideo() async {
    //获取录制视频
    XFile? pickedFile = await _picker.pickVideo(
      //指定选择图片的类型相机
      source: ImageSource.camera,
    );
    print(pickedFile);
    if (pickedFile != null) {
      //1.获取到视频资源后
      // print(pickedFile.path);
      //2.再初始化视频播放器
      await _initVideo(File(pickedFile.path));
      //3.然后在把数据赋值到播放器上
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  //选择视频一个
  _pickGalleryVideo() async {
    //获取选择的照片
    XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
      //默认选择的图片很大 需要指定下宽高
    );
    print(pickedFile);
    if (pickedFile != null) {
      print("------------");
      //1.获取到视频资源后
      print(pickedFile.path);
      //2.再初始化视频播放器
      await _initVideo(File(pickedFile.path));
      //3.然后在把数据赋值到播放器上
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //记得销毁两个播放器
    try {
      videoPlayerController.dispose();
      chewieController.dispose();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _pickCameraVideo, child: Text("录制视频")),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _pickGalleryVideo, child: Text("相册选择视频")),
            SizedBox(
              height: 20,
            ),
            _pickedFile == null
                ? Text("选择的视频...")
                : AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: chewieController),
                  )
          ],
        ),
      ),
    );
  }
}
