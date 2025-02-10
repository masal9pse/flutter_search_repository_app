import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

// Amount the sheet in the background scales down. Found by measuring the width
// of the sheet in the background and comparing against the screen width on the
// iOS simulator showing an iPhone 16 pro running iOS 18.0. The scale transition
// will go from a default of 1.0 to 1.0 - _kSheetScaleFactor.
const double _kSheetScaleFactor = 0.0835;

final Animatable<double> _kScaleTween =
    Tween<double>(begin: 1.0, end: 1.0 - _kSheetScaleFactor);

class CupertinoSheetRoute<T> extends PageRoute<T> {
  /// Creates a page route that displays an iOS styled sheet.
  CupertinoSheetRoute({required this.builder});

  /// Builds the primary contents of the sheet route.
  final WidgetBuilder builder;

  /// Checks if a Cupertino sheet view exists in the widget tree above the current
  /// context.
  static bool hasParentSheet(BuildContext context) {
    // return _CupertinoSheetScope.maybeOf(context) != null;
    return false;
  }

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
  @override
  DelegatedTransitionBuilder? get delegatedTransition =>
      _CupertinoSheetTransition.delegateTransition;

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

  // staticメソッドだからどこに定義しても挙動は変わらん。
  static Widget delegateTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    final Curve curve = Curves.linearToEaseOut;
    final Curve reverseCurve = Curves.easeInToLinear;
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: curve,
      reverseCurve: reverseCurve,
      parent: secondaryAnimation,
    );
    final double deviceCornerRadius =
        MediaQuery.maybeViewPaddingOf(context)?.top ?? 0;

    final Animatable<BorderRadiusGeometry> decorationTween =
        Tween<BorderRadiusGeometry>(
      begin: BorderRadius.circular(deviceCornerRadius),
      end: BorderRadius.circular(12),
    );

    final Animatable<Offset> kTopDownTween = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, 0.07),
    );

    final Animatable<double> kOpacityTween =
        Tween<double>(begin: 0.0, end: 0.10);

    final Animation<BorderRadiusGeometry> radiusAnimation =
        curvedAnimation.drive(decorationTween);
    final Animation<double> opacityAnimation =
        curvedAnimation.drive(kOpacityTween);
    final Animation<Offset> slideAnimation =
        curvedAnimation.drive(kTopDownTween);
    final Animation<double> scaleAnimation =
        curvedAnimation.drive(_kScaleTween);
    curvedAnimation.dispose();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final Color overlayColor = const Color(0xFF000000);

    final Widget contrastedChild = Stack(
      children: <Widget>[
        child!,
        FadeTransition(
          opacity: opacityAnimation,
          child: ColoredBox(
            color: overlayColor,
            child: const SizedBox(),
          ),
        ),
      ],
    );

    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        filterQuality: FilterQuality.medium,
        alignment: Alignment.topCenter,
        child: AnimatedBuilder(
          animation: radiusAnimation,
          child: child,
          builder: (BuildContext context, Widget? child) {
            return ClipRRect(
              borderRadius: radiusAnimation.value,
              child: contrastedChild,
            );
          },
        ),
      ),
    );
  }

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

  static Widget _coverSheetPrimaryTransition(
    BuildContext context,
    Animation<double> animation,
    Widget? child,
  ) {
    final Animatable<Offset> kBottomUpTween = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.08),
    );

    final Animatable<Offset> kBottomUpTweenWhenCoveringOtherSheet =
        Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, -0.02),
    );
    final Animatable<Offset> offsetTween =
        CupertinoSheetRoute.hasParentSheet(context)
            ? kBottomUpTweenWhenCoveringOtherSheet
            : kBottomUpTween;

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.fastEaseInToSlowEaseOut,
      reverseCurve: Curves.fastEaseInToSlowEaseOut.flipped,
    );

    final Animation<Offset> positionAnimation =
        curvedAnimation.drive(offsetTween);

    curvedAnimation.dispose();

    return SlideTransition(position: positionAnimation, child: child);
  }
}
