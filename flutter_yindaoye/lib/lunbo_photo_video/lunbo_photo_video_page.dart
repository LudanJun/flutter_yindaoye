import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yindaoye/cart/listData.dart';
import 'package:video_player/video_player.dart';

/// 轮播图 - 播放图片和shop
class LunboPhotoVideoPage extends StatefulWidget {
  const LunboPhotoVideoPage({super.key});

  @override
  State<LunboPhotoVideoPage> createState() => _LunboPhotoVideoPageState();
}

class _LunboPhotoVideoPageState extends State<LunboPhotoVideoPage> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then(
        (_) {
          setState(
            () {},
          );
        },
      );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("轮播图片和视频"),
      ),
      body: Container(
        child: CarouselSlider(
          items: [
            //图片项
            Image.network(imageUrl1),
            Image.network(imageUrl2),
            //视频项
            _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(
                      _videoController,
                    ),
                  )
                : Container(
                    color: Colors.black,
                  ), // 占位符
          ],
          options: CarouselOptions(
            autoPlay: true,
            height: 500,
          ),
        ),
      ),
    );
  }
}
