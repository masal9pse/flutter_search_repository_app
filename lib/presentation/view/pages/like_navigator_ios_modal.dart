import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared View Demo',
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
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Go to Detail Page'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const DetailPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // 元画面のスケールダウンアニメーション
      const beginScale = 1.0;
      const endScale = 0.9; // 背景を縮小
      const curve = Curves.easeInOut;

      final scaleTween = Tween(begin: beginScale, end: endScale)
          .chain(CurveTween(curve: curve));
      final scaleAnimation = animation.drive(scaleTween);

      // 新しい画面のフェードインアニメーション
      const beginOpacity = 0.0;
      const endOpacity = 1.0;
      final opacityTween = Tween(begin: beginOpacity, end: endOpacity)
          .chain(CurveTween(curve: curve));
      final opacityAnimation = animation.drive(opacityTween);

      return Stack(
        children: [
          // 背景画面のアニメーション
          ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: animation,
              child: Container(
                color: Colors.black.withOpacity(0.2), // 背景ぼかし
              ),
            ),
          ),
          // 新しい画面のフェードイン
          FadeTransition(
            opacity: opacityAnimation,
            child: child,
          ),
        ],
      );
    },
  );
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Page')),
      body: const Center(
        child: Text('This is the Detail Page'),
      ),
    );
  }
}
