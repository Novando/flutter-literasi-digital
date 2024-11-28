import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final String baseUrl = 'http://localhost/';
  List<String> files = [];
  List<String> vidUrls = [];
  List<String> picUrls = [];
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    init();
  }

  Future init() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final links = document.querySelectorAll('a');
        setState(() {
          files = links.map((e) => e.text).toList();
        });
      } else {
        throw Exception('Failed to load directory');
      }
    } catch (e) {
      print('Error fetching directory: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ?
        const Center(child: CircularProgressIndicator()) :
        files.isEmpty ?
        const Center(child: Text('NO DATA')) :
        const Row()
        // ListView.builder(
        // itemBuilder: (c, i) {
        //   return ListTile(
        //     title: Text(files[i]),
        //   );
        // }),
    );
  }
}