import 'package:blackbox/entities/url.dart';
import 'package:blackbox/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class SplashScreenPages extends StatefulWidget {
  const SplashScreenPages({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenPagesState();
}

class SplashScreenPagesState extends State<SplashScreenPages> {
  final String hostUrl = 'http://192.168.132.197/';
  List<String> files = [];
  bool isLoading = true;
  UrlEntity? fileUrls;

  @override
  initState() {
    super.initState();
    init();
  }

  Future init() async {
    try {
      final res = await pathCheck(hostUrl);
      fileUrls = filterFiles(res);
    } catch (e) {
      print('Error reading file paths: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<List<String>> pathCheck(String baseUrl) async {
    List<String> links = [];
    try {
      final res = await http.get(Uri.parse(baseUrl));
      if (res.statusCode == 200) {
        final document = parse(res.body);
        final queries = document.querySelectorAll('a');
        for (int i = 0; i < queries.length; i++) {
          if (queries[i].text == '../') continue;
          final pathUrl = "$baseUrl${queries[i].text}";
          if (queries[i].text.contains('/')) {
            links.addAll(await pathCheck(pathUrl));
          } else {
            links.add(pathUrl);
          }
        }
      } else {
        throw Exception('Failed to load directory');
      }
    } catch (e) {
      print('Error fetching directory: $e');
    }
    return links;
  }

  UrlEntity filterFiles(List<String> arg) {
    const imgExts = ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'webp'];
    const vidExts = ['mp4', 'mkv', 'flv', 'avi', 'mov', 'ts', 'wmv'];
    List<String> vids = [];
    List<String> imgs = [];
    arg.forEach((e) {
      final ext = e.split('.').last.toLowerCase();
      if (imgExts.contains(ext)) {
        imgs.add(e);
      } else if (vidExts.contains(ext)) {
        vids.add(e);
      }
    });
    return new UrlEntity(vids, imgs);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ?
        const Center(child: CircularProgressIndicator()) :
        fileUrls != null ?
        HomePages(filesPath: fileUrls) :
        const Center(child: Text('NO DATA'))
    );
  }
}