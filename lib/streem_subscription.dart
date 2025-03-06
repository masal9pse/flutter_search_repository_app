import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  String _currentFruit = 'Apple';

  void _startTimer() {
    final words = ['Hello', 'World', 'Flutter', 'Stream'];
    Stream.periodic(
      Duration(seconds: 1),
      (count) => words[count % words.length], // 配列のループ
    ).listen((word) {
      setState(() {
        _currentFruit = word;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          _currentFruit,
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
