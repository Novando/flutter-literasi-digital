import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';          // Provides [VideoController] & [Video] etc.


class VideoListPages extends StatefulWidget {
  final List<String> vidUrls;

  const VideoListPages({super.key, required this.vidUrls});

  @override
  State<StatefulWidget> createState() => VideoListState();
}

class VideoListState extends State<VideoListPages> {
  late final Player player = Player();
  // late List<VideoController> _controllers;
  late final VideoController _controller = VideoController(player);
  late bool isLoading = true;

  @override
  initState() {
    super.initState();
    init();
  }

  init() {
    // List<VideoController> ctrls = [];
    // widget.vidUrls.forEach((e) {
    //   ctrls.add(VideoPlayerController.networkUrl(Uri.parse(e))
    //     ..initialize().then((_) {
    //     }));
    // });
    print('url: ${widget.vidUrls[0]}');
    player.open(Media('http://localhost/video/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
    setState(() { isLoading = false; });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? CircularProgressIndicator() : Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9 / 16,
          child: Video(controller: _controller),
        )
      )
      // GridView.count(
      //   crossAxisCount: 2,
      //   children: _controllers.map((e) {
      //     return e.value.isInitialized ?
      //     AspectRatio(aspectRatio: e.value.aspectRatio, child: VideoPlayer(e)) :
      //     Container();
      //   }).toList(),
      //
      // )
    );
  }
}