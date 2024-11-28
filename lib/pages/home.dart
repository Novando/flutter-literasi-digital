import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          Column(
            children: [
              Text('Test 1'),
              Text('Test 2'),
            ],
          )
        ],
      ),
    );
  }
}