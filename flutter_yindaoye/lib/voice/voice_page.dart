import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class VoicePage extends StatefulWidget {
  const VoicePage({super.key});

  @override
  State<VoicePage> createState() => _VoicePageState();
}

class _VoicePageState extends State<VoicePage> {
  final player = AudioPlayer();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("音频播放"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await player.play(
                  UrlSource(
                      "https://www.cambridgeenglish.org/images/153149-movers-sample-listening-test-vol2.mp3"),
                );
              },
              child: Text("播放"),
            ),
            ElevatedButton(
              onPressed: () async {
                await player.stop();
              },
              child: Text("暂停"),
            ),
          ],
        ),
      ),
    );
  }
}
