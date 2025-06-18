// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DualScreenDemo(),
    );
  }
}

class DualScreenDemo extends StatelessWidget {
  const DualScreenDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final displayFeatures = MediaQuery.of(context).displayFeatures;

    if (displayFeatures.isEmpty) {
      // 折り目がない場合は普通に表示
      return const Scaffold(
        body: Center(child: Text("通常表示")),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // 左側画面
          Expanded(
            child: DisplayFeatureSubScreen(
              anchorPoint: Offset.zero,              
              child: Container(
                color: Colors.blue[100],
                child: const Center(child: Text("左画面")),
              ),
            ),
          ),
          // 右側画面
          Expanded(
            child: DisplayFeatureSubScreen(
              anchorPoint: Offset(0.5,0.5),
              // displayFeatures: displayFeatures,
              child: Container(
                color: Colors.green[100],
                child: const Center(child: Text("右画面")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
