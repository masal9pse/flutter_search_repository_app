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
  late final StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  String _currentFruit = 'Apple';

  void _startTimer() {
    final words = ['Hello', 'World', 'Flutter', 'Stream'];
    _subscription = Stream.periodic(
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
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            _subscription.pause();
          },
          child: Text('stop'),
        ),
      ),
      body: Center(
        child: Text(
          _currentFruit,
          style: TextStyle(fontSize: 32),
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: _subscription.resume, child: Text('resume')),
    );
  }
}
