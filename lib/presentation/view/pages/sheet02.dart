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
              // CustomPageRoute(
              //   const NextPage(),
              // ),
              CustomPageRouteBuilder(
                child: NextPage(),
              ),
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

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);

  @override
  Color get barrierColor => Colors.red;

  @override
  String? get barrierLabel => null;

  final Widget child;

  // // doubleが強制される
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // ここを変えればいろんなトランジションにできるぞ
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(
        milliseconds: 1000, // ミリ秒でトランジションにかかる時間を指定
      );
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

  @override
  DelegatedTransitionBuilder? get delegatedTransition => delegateTransition;
  
  // staticメソッドだからどこに定義しても挙動は変わらん。
  // delegateTransitionは後ろの画面を担当していそう
  static Widget delegateTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.easeInToLinear,
      parent: secondaryAnimation,
    );

    final Animation<BorderRadiusGeometry> radiusAnimation =
        curvedAnimation.drive(
      Tween<BorderRadiusGeometry>(
        begin: BorderRadius.circular(0),
        end: BorderRadius.circular(12),
      ),
    );    

    return SlideTransition(
      position: curvedAnimation.drive(
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.0, 0.07),
        ),
      ),
      child: ScaleTransition(
        scale: curvedAnimation.drive(Tween<double>(begin: 1.0, end: 1.0 - 0.0835)),
        filterQuality: FilterQuality.medium,
        alignment: Alignment.topCenter,
        child: AnimatedBuilder(
          animation: radiusAnimation,
          child: child,
          builder: (BuildContext context, Widget? child) {
            return ClipRRect(
              borderRadius: radiusAnimation.value,
              child: child,
            );
          },
        ),
      ),
    );
  }

}
