import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MeditKitPage extends StatefulWidget {
  const MeditKitPage({super.key});

  @override
  State<MeditKitPage> createState() => _MeditKitPageState();
}

class _MeditKitPageState extends State<MeditKitPage> {
  late final player = Player(
    configuration: PlayerConfiguration(
      // Supply your options:
      title: 'My awesome package:media_kit application',
      ready: () {
        print('The initialization is complete.');
      },
    ),
  );
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    // player.open(Media(
    //     'https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
    player.open(Media('https://media.w3.org/2010/05/sintel/trailer.mp4'));
    player.setVolume(50.0);
    //禁用跟踪
    //这基本上可用于禁用视频输出、禁用音频输出或停止字幕渲染等。
    player.setVideoTrack(VideoTrack.no());
    // player.setAudioTrack(AudioTrack.no());
    // player.setSubtitleTrack(SubtitleTrack.no());
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          // Use [Video] widget to display video output.
          child: Video(controller: controller),
        ),
      ),
    );
  }
}
