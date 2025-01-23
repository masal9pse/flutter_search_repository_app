import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Modal Demo',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true, // 高さをカスタマイズするために必要
              backgroundColor: Colors.transparent, // 背景を透過
              builder: (context) => const CustomModal(),
            );
          },
          child: const Text('Show Modal'),
        ),
      ),
    );
  }
}

class CustomModal extends StatelessWidget {
  const CustomModal({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return DraggableScrollableSheet(
      initialChildSize: 0.9, // 初期サイズ：90%
      minChildSize: 0.9, // 最小サイズ：90%
      maxChildSize: 0.9, // 最大サイズ：90%
      builder: (context, scrollController) {
        return Container(
          height: screenHeight * 0.9, // 高さを明示的に指定
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ListView(
            controller: scrollController, // スクロール可能にする
            children: const [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'This modal fills 90% of the screen height.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              // 必要に応じてさらにウィジェットを追加可能
            ],
          ),
        );
      },
    );
  }
}
