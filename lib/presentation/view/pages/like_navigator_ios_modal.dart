import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Transition Demo',
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
              isScrollControlled: true, // モーダルが画面全体を使用できるようにする
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

    return Stack(
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pop(), // モーダル外をタップで閉じる
          child: Container(
            color: Colors.black.withOpacity(0.5), // 背景を薄暗くする
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.8, // 初期サイズ（画面の高さ80%）
          minChildSize: 0.5, // 最小サイズ（50%）
          maxChildSize: 0.8, // 最大サイズ（80%）
          builder: (context, scrollController) {
            return Container(
              height: screenHeight * 0.8,
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
                      'This is a custom modal sheet.',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  // 必要に応じてウィジェットを追加
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
