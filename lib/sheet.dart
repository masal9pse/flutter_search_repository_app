import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

final Animatable<Offset> _kBottomUpTween = Tween<Offset>(
  begin: const Offset(0.0, 1.0),
  end: const Offset(0.0, 0.08),
);

// Offset change for when a new sheet covers another sheet. '0.0' represents the
// top of the space available for the new sheet, but because the previous sheet
// was lowered slightly, the new sheet needs to go slightly higher than that.
// Values found from eyeballing a simulator running iOS 18.0.
final Animatable<Offset> _kBottomUpTweenWhenCoveringOtherSheet = Tween<Offset>(
  begin: const Offset(0.0, 1.0),
  end: const Offset(0.0, -0.02),
);

// Tween that animates a sheet slightly up when it is covered by a new sheet.
// Values found from eyeballing a simulator running iOS 18.0.
final Animatable<Offset> _kMidUpTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(0.0, -0.005),
);

// Offset from top of screen to slightly down when a fullscreen page is covered
// by a sheet. Values found from eyeballing a simulator running iOS 18.0.
final Animatable<Offset> _kTopDownTween = Tween<Offset>(
  begin: Offset.zero,
  end: const Offset(0.0, 0.07),
);

// Opacity of the overlay color put over the sheet as it moves into the background.
// Used to distinguish the sheet from the background. Value derived from eyeballing
// a simulator running iOS 18.0.
final Animatable<double> _kOpacityTween = Tween<double>(begin: 0.0, end: 0.10);

// Amount the sheet in the background scales down. Found by measuring the width
// of the sheet in the background and comparing against the screen width on the
// iOS simulator showing an iPhone 16 pro running iOS 18.0. The scale transition
// will go from a default of 1.0 to 1.0 - _kSheetScaleFactor.
const double _kSheetScaleFactor = 0.0835;

final Animatable<double> _kScaleTween = Tween<double>(begin: 1.0, end: 1.0 - _kSheetScaleFactor);


/// このクラスを消すと、モーダル遷移の挙動が普通の遷移になった。
/// Provides an iOS-style sheet transition.
///
/// The page slides up and stops below the top of the screen. When covered by
/// another sheet view, it will slide slightly up and scale down to appear
/// stacked behind the new sheet.
class _CupertinoSheetTransition extends StatefulWidget {
  /// Creates an iOS style sheet transition.
  const _CupertinoSheetTransition({
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.child,
    required this.linearTransition,
  });

  /// `primaryRouteAnimation` is a linear route animation from 0.0 to 1.0 when
  /// this screen is being pushed.
  final Animation<double> primaryRouteAnimation;

  /// `secondaryRouteAnimation` is a linear route animation from 0.0 to 1.0 when
  /// another screen is being pushed on top of this one.
  final Animation<double> secondaryRouteAnimation;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Whether to perform the transition linearly.
  ///
  /// Used to respond to a drag gesture.
  final bool linearTransition;

  /// The primary delegated transition. Will slide a non [CupertinoSheetRoute] page down.
  ///
  /// Provided to the previous route to coordinate transitions between routes.
  ///
  /// If a [CupertinoSheetRoute] already exists in the stack, then it will
  /// slide the previous sheet upwards instead.
  static Widget delegateTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting,
    Widget? child,
  ) {
    if (CupertinoSheetRoute.hasParentSheet(context)) {
      return _delegatedCoverSheetSecondaryTransition(secondaryAnimation, child);
    }
    final bool linear = Navigator.of(context).userGestureInProgress;

    final Curve curve = linear ? Curves.linear : Curves.linearToEaseOut;
    final Curve reverseCurve = linear ? Curves.linear : Curves.easeInToLinear;
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: curve,
      reverseCurve: reverseCurve,
      parent: secondaryAnimation,
    );
    final double deviceCornerRadius = MediaQuery.maybeViewPaddingOf(context)?.top ?? 0;

    final Animatable<BorderRadiusGeometry> decorationTween = Tween<BorderRadiusGeometry>(
      begin: BorderRadius.circular(deviceCornerRadius),
      end: BorderRadius.circular(12),
    );

    final Animation<BorderRadiusGeometry> radiusAnimation = curvedAnimation.drive(decorationTween);
    final Animation<double> opacityAnimation = curvedAnimation.drive(_kOpacityTween);
    final Animation<Offset> slideAnimation = curvedAnimation.drive(_kTopDownTween);
    final Animation<double> scaleAnimation = curvedAnimation.drive(_kScaleTween);
    curvedAnimation.dispose();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final bool isDarkMode = CupertinoTheme.brightnessOf(context) == Brightness.dark;
    final Color overlayColor = isDarkMode ? const Color(0xFFc8c8c8) : const Color(0xFF000000);

    final Widget? contrastedChild =
        child != null && !secondaryAnimation.isDismissed
            ? Stack(
              children: <Widget>[
                child,
                FadeTransition(
                  opacity: opacityAnimation,
                  child: ColoredBox(color: overlayColor, child: const SizedBox.expand()),
                ),
              ],
            )
            : child;

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
            return ClipRRect(borderRadius: radiusAnimation.value, child: contrastedChild);
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
  State<_CupertinoSheetTransition> createState() => _CupertinoSheetTransitionState();
}

class _CupertinoSheetTransitionState extends State<_CupertinoSheetTransition> {

  // Curve of primary page which is coming in to cover another route.
  CurvedAnimation? _primaryPositionCurve;

  // Curve of secondary page which is becoming covered by another sheet.
  CurvedAnimation? _secondaryPositionCurve;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void didUpdateWidget(covariant _CupertinoSheetTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.primaryRouteAnimation != widget.primaryRouteAnimation ||
        oldWidget.secondaryRouteAnimation != widget.secondaryRouteAnimation) {
      _disposeCurve();
      _setupAnimation();
    }
  }

  @override
  void dispose() {
    _disposeCurve();
    super.dispose();
  }

  void _setupAnimation() {
    _primaryPositionCurve = CurvedAnimation(
      curve: Curves.fastEaseInToSlowEaseOut,
      reverseCurve: Curves.fastEaseInToSlowEaseOut.flipped,
      parent: widget.primaryRouteAnimation,
    );
    _secondaryPositionCurve = CurvedAnimation(
      curve: Curves.linearToEaseOut,
      reverseCurve: Curves.easeInToLinear,
      parent: widget.secondaryRouteAnimation,
    );
  }

  void _disposeCurve() {
    _primaryPositionCurve?.dispose();
    _secondaryPositionCurve?.dispose();
    _primaryPositionCurve = null;
    _secondaryPositionCurve = null;
  }

  Widget _coverSheetPrimaryTransition(
    BuildContext context,
    Animation<double> animation,
    bool linearTransition,
    Widget? child,
  ) {
    final Animatable<Offset> offsetTween =
        CupertinoSheetRoute.hasParentSheet(context)
            ? _kBottomUpTweenWhenCoveringOtherSheet
            : _kBottomUpTween;

    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: linearTransition ? Curves.linear : Curves.fastEaseInToSlowEaseOut,
      reverseCurve: linearTransition ? Curves.linear : Curves.fastEaseInToSlowEaseOut.flipped,
    );

    final Animation<Offset> positionAnimation = curvedAnimation.drive(offsetTween);

    curvedAnimation.dispose();

    return SlideTransition(position: positionAnimation, child: child);
  }

  @override
  Widget build(BuildContext context) {
    // このコードだとシートを積み上げる際に本体が上に上がっていかない
    return SizedBox.expand(
      child: _coverSheetPrimaryTransition(
          context,
          widget.primaryRouteAnimation,
          widget.linearTransition,
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: widget.child,
          ),
        )
    );
  }
}

class CupertinoSheetRoute<T> extends PageRoute<T> with _CupertinoSheetRouteTransitionMixin<T> {
// class CupertinoSheetRoute<T> extends PageRoute<T> {
  /// Creates a page route that displays an iOS styled sheet.
  CupertinoSheetRoute({required this.builder});

  /// Builds the primary contents of the sheet route.
  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) {
    return builder(context);
  }

  /// Checks if a Cupertino sheet view exists in the widget tree above the current
  /// context.
  static bool hasParentSheet(BuildContext context) {
    // return _CupertinoSheetScope.maybeOf(context) != null;
    return false;
  }

  @override
  Color? get barrierColor => CupertinoColors.transparent;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;
}

/// A mixin that replaces the entire screen with an iOS sheet transition for a
/// [PageRoute].
///
/// See also:
///
///  * [CupertinoSheetRoute], which is a [PageRoute] that leverages this mixin.
mixin _CupertinoSheetRouteTransitionMixin<T> on PageRoute<T> {
  /// Builds the primary contents of the route.
  @protected
  Widget buildContent(BuildContext context);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  DelegatedTransitionBuilder? get delegatedTransition =>
      _CupertinoSheetTransition.delegateTransition;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return buildContent(context);
  }

  /// Returns a [_CupertinoSheetTransition].
  static Widget buildPageTransitions<T>(
    ModalRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final bool linearTransition = route.popGestureInProgress;
    return _CupertinoSheetTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: linearTransition,
      child: child,
    );
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return nextRoute is _CupertinoSheetRouteTransitionMixin;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return buildPageTransitions<T>(this, context, animation, secondaryAnimation, child);
  }
}