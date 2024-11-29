import 'package:flutter/material.dart';

class PictureListPages extends StatelessWidget {
  final List<String> imgUrls;
  const PictureListPages({super.key, required this.imgUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: imgUrls.map((e) => Image.network(e)).toList(),
      )
    );
  }
}