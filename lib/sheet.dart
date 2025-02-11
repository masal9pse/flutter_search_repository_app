import 'package:flutter/cupertino.dart';

class CupertinoSheetRoute<T> extends PageRoute<T> {
  /// Creates a page route that displays an iOS styled sheet.
  CupertinoSheetRoute({required this.builder});

  /// Builds the primary contents of the sheet route.
  final WidgetBuilder builder;

  @override
  // Color? get barrierColor => CupertinoColors.transparent;
  Color? get barrierColor => null;

  @override
  bool get opaque => false; // これがfalseだと、遷移したあとに後ろの画面が消えない。
  // bool get opaque => true; // これをtrueにすると、遷移したあとに後ろの画面が消える。
  // opaqueを消してもエラーにならないので、親クラスでopaqueの定義がされているはず。trueで

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration =>
      const Duration(milliseconds: 500); // 遷移が完了するまでの時間

  // これをコメントアウトするとアニメーションのないpush遷移になる。
  // 掘っていくと初期値nullが定義されていた。
  // 後ろの画面のアニメーションを担当
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

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  // これをコメントアウトするとアニメーションのないpush遷移になる。
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return _CupertinoSheetTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      child: child,
    );
  }
}

class _CupertinoSheetTransition extends StatelessWidget {
  /// Creates an iOS style sheet transition.
  const _CupertinoSheetTransition({
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.child,
  });

  /// `primaryRouteAnimation` is a linear route animation from 0.0 to 1.0 when
  /// this screen is being pushed.
  final Animation<double> primaryRouteAnimation;

  /// `secondaryRouteAnimation` is a linear route animation from 0.0 to 1.0 when
  /// another screen is being pushed on top of this one.
  final Animation<double> secondaryRouteAnimation;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _coverSheetPrimaryTransition(
        context,
        primaryRouteAnimation,
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: child,
        ),
      ),
    );
  }

  // まずここをみるか
  // 遷移先の画面
  static Widget _coverSheetPrimaryTransition(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  ) {
    final Animatable<Offset> kBottomUpTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.08),
    );

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.fastEaseInToSlowEaseOut,
      reverseCurve: Curves.fastEaseInToSlowEaseOut.flipped,
    );

    final Animation<Offset> positionAnimation =
        curvedAnimation.drive(kBottomUpTween);

    curvedAnimation.dispose();

    return SlideTransition(position: positionAnimation, child: child);
  }
}
