import 'package:blackbox/entities/url.dart';
import 'package:blackbox/pages/picture_list.dart';
import 'package:blackbox/pages/video_list.dart';
import 'package:flutter/material.dart';

class HomePages extends StatelessWidget {
  final UrlEntity? filesPath;
  const HomePages({super.key, required this.filesPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              FilledButton(
                onPressed: () { Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PictureListPages(imgUrls: filesPath!.images)
                  )
                ); },
                child: Text('${filesPath!.images.length} Picture(s)'),
              ),
              FilledButton(
                onPressed: () { Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => VideoListPages(vidUrls: filesPath!.videos)
                    )
                ); },
                child: Text('${filesPath!.videos.length} Video(s)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}