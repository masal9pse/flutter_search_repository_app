import 'package:flutter/cupertino.dart';

// Tween that animates a sheet slightly up when it is covered by a new sheet.
// Values found from eyeballing a simulator running iOS 18.0.
final Animatable<Offset> _kMidUpTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(0.0, -0.005),
);

// Amount the sheet in the background scales down. Found by measuring the width
// of the sheet in the background and comparing against the screen width on the
// iOS simulator showing an iPhone 16 pro running iOS 18.0. The scale transition
// will go from a default of 1.0 to 1.0 - _kSheetScaleFactor.
const double _kSheetScaleFactor = 0.0835;

final Animatable<double> _kScaleTween = Tween<double>(begin: 1.0, end: 1.0 - _kSheetScaleFactor);

// sheet01.dartで実装
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
  // いじった感じ、後ろの画面(遷移元)のアニメーションを担当
  @override
  DelegatedTransitionBuilder? get delegatedTransition => delegateTransition;

  static Widget delegateTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    //  if (CupertinoSheetRoute.hasParentSheet(context)) {
    // if (true) {
    //   return _delegatedCoverSheetSecondaryTransition(secondaryAnimation, child);
    // }

    // 親（後ろになる一つ前の）画面が通常の画面のとき
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
          // end: const Offset(0.0, 0.1),
        ),
      ),
      transformHitTests: false,
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

  static Widget _delegatedCoverSheetSecondaryTransition(
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    const Curve curve = Curves.linearToEaseOut;
    const Curve reverseCurve = Curves.easeInToLinear;
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: curve,
      reverseCurve: reverseCurve,
      parent: secondaryAnimation,
    );

    final Animation<Offset> slideAnimation = curvedAnimation.drive(_kMidUpTween);
    final Animation<double> scaleAnimation = curvedAnimation.drive(_kScaleTween);
    curvedAnimation.dispose();

    return SlideTransition(
      position: slideAnimation,
      transformHitTests: false,
      child: ScaleTransition(
        scale: scaleAnimation,
        filterQuality: FilterQuality.medium,
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: child,
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
  // おそらくこれが遷移先のモーダルのアニメーションを担当している。
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
      // end: const Offset(0.0, 0.2),
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
