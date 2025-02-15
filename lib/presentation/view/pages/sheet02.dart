import 'package:flutter/material.dart';

// ref: https://zenn.dev/pressedkonbu/books/flutter-reverse-lookup-dictionary/viewer/025-custom-page-route
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ページ遷移をカスタムしたい'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    NextPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                transitionDuration: const Duration(milliseconds: 1000),
                barrierColor: Colors.blue,
              ),
              // PageRoute(),
            );
          },
          child: const Text(
            'NEXT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: FlutterLogo(
          size: 120,
        ),
      ),
    );
  }
}

// PageRouteBuilderでは後ろの画面をいじるやり方がない説？
class CustomPageRouteBuilder extends PageRouteBuilder {
  CustomPageRouteBuilder({required Widget child})
      : super(
          barrierColor: Colors.amber, // getterどちらの定義するとgetterが適応される
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 1000),
        );

  // @override
  // Color get barrierColor => Colors.red;
}
