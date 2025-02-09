import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

// The minimum velocity needed for a drag downwards to dismiss the sheet. Eyeballed
// from a comparison against a simulator running iOS 18.0.
const double _kMinFlingVelocity = 2.0; // Screen heights per second.

// The duration for a page to animate when the user releases it mid-swipe. Eyeballed
// from a comparison against a simulator running iOS 18.0.
const Duration _kDroppedSheetDragAnimationDuration = Duration(milliseconds: 300);

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
class CupertinoSheetTransition extends StatefulWidget {
  /// Creates an iOS style sheet transition.
  const CupertinoSheetTransition({
    super.key,
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
  State<CupertinoSheetTransition> createState() => _CupertinoSheetTransitionState();
}

class _CupertinoSheetTransitionState extends State<CupertinoSheetTransition> {
  // The offset animation when this page is being covered by another sheet.
  late Animation<Offset> _secondaryPositionAnimation;

  // The scale animation when this page is being covered by another sheet.
  late Animation<double> _secondaryScaleAnimation;

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
  void didUpdateWidget(covariant CupertinoSheetTransition oldWidget) {
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
    _secondaryPositionAnimation = _secondaryPositionCurve!.drive(_kMidUpTween);
    _secondaryScaleAnimation = _secondaryPositionCurve!.drive(_kScaleTween);
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
      CupertinoSheetTransition.delegateTransition;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return buildContent(context);
  }

  static _CupertinoDownGestureController<T> _startPopGesture<T>(ModalRoute<T> route) {
    return _CupertinoDownGestureController<T>(
      navigator: route.navigator!,
      getIsCurrent: () => route.isCurrent,
      getIsActive: () => route.isActive,
      controller: route.controller!, // protected access
    );
  }

  /// Returns a [CupertinoSheetTransition].
  static Widget buildPageTransitions<T>(
    ModalRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final bool linearTransition = route.popGestureInProgress;
    return CupertinoSheetTransition(
      primaryRouteAnimation: animation,
      secondaryRouteAnimation: secondaryAnimation,
      linearTransition: linearTransition,
      child: _CupertinoDownGestureDetector<T>(
        // enableCallbackをfalseにするとドラッグできなくなる。
        enabledCallback: () => true,
        // enabledCallback: () => false,
        onStartPopGesture: () => _startPopGesture<T>(route),
        child: child,
      ),
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

class _CupertinoDownGestureDetector<T> extends StatefulWidget {
  const _CupertinoDownGestureDetector({
    super.key,
    required this.enabledCallback,
    required this.onStartPopGesture,
    required this.child,
  });

  final Widget child;

  final ValueGetter<bool> enabledCallback;

  final ValueGetter<_CupertinoDownGestureController<T>> onStartPopGesture;

  @override
  _CupertinoDownGestureDetectorState<T> createState() => _CupertinoDownGestureDetectorState<T>();
}

class _CupertinoDownGestureDetectorState<T> extends State<_CupertinoDownGestureDetector<T>> {
  _CupertinoDownGestureController<T>? _downGestureController;

  late VerticalDragGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer =
        VerticalDragGestureRecognizer(debugOwner: this)
          ..onStart = _handleDragStart
          ..onUpdate = _handleDragUpdate
          ..onEnd = _handleDragEnd
          ..onCancel = _handleDragCancel;
  }

  @override
  void dispose() {
    _recognizer.dispose();

    // If this is disposed during a drag, call navigator.didStopUserGesture.
    if (_downGestureController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_downGestureController?.navigator.mounted ?? false) {
          _downGestureController?.navigator.didStopUserGesture();
        }
        _downGestureController = null;
      });
    }
    super.dispose();
  }

  void _handleDragStart(DragStartDetails details) {
    assert(mounted);
    assert(_downGestureController == null);
    _downGestureController = widget.onStartPopGesture();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    assert(mounted);
    assert(_downGestureController != null);
    final double topGapRatio = (_kBottomUpTween as Tween<Offset>).end?.dy ?? 0.08;
    _downGestureController!.dragUpdate(
      // Devide by size of the sheet. The gap between the top of the sheet and
      // top of the screen is 0.08.
      details.primaryDelta! / (context.size!.height - (context.size!.height * topGapRatio)),
    );
  }

  void _handleDragEnd(DragEndDetails details) {
    assert(mounted);
    assert(_downGestureController != null);
    _downGestureController!.dragEnd(details.velocity.pixelsPerSecond.dy / context.size!.height);
    _downGestureController = null;
  }

  void _handleDragCancel() {
    assert(mounted);
    // This can be called even if start is not called, paired with the "down" event
    // that we don't consider here.
    _downGestureController?.dragEnd(0.0);
    _downGestureController = null;
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (widget.enabledCallback()) {
      _recognizer.addPointer(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        widget.child,
        Listener(onPointerDown: _handlePointerDown, behavior: HitTestBehavior.translucent),
      ],
    );
  }
}

class _CupertinoDownGestureController<T> {
  /// Creates a controller for an iOS-style back gesture.
  _CupertinoDownGestureController({
    required this.navigator,
    required this.controller,
    required this.getIsActive,
    required this.getIsCurrent,
  }) {
    navigator.didStartUserGesture();
  }

  final AnimationController controller;
  final NavigatorState navigator;
  final ValueGetter<bool> getIsActive;
  final ValueGetter<bool> getIsCurrent;

  /// The drag gesture has changed by [delta]. The total range of the drag
  /// should be 0.0 to 1.0.
  void dragUpdate(double delta) {
    controller.value -= delta;
  }

  /// The drag gesture has ended with a vertical motion of [velocity] as a
  /// fraction of screen height per second.
  void dragEnd(double velocity) {
    // Fling in the appropriate direction.
    //
    // This curve has been determined through rigorously eyeballing native iOS
    // animations on a simulator running iOS 18.0.
    const Curve animationCurve = Curves.easeOut;
    final bool isCurrent = getIsCurrent();
    final bool animateForward;

    if (!isCurrent) {
      // If the page has already been navigated away from, then the animation
      // direction depends on whether or not it's still in the navigation stack,
      // regardless of velocity or drag position. For example, if a route is
      // being slowly dragged back by just a few pixels, but then a programmatic
      // pop occurs, the route should still be animated off the screen.
      // See https://github.com/flutter/flutter/issues/141268.
      animateForward = getIsActive();
    } else if (velocity.abs() >= _kMinFlingVelocity) {
      // If the user releases the page before mid screen with sufficient velocity,
      // or after mid screen, we should animate the page out. Otherwise, the page
      // should be animated back in.
      animateForward = velocity <= 0;
    } else {
      // If the drag is dropped with low velocity, the sheet will pop if the
      // the drag goes a little past the halfway point on the screen. This is
      // eyeballed on a simulator running iOS 18.0.
      animateForward = controller.value > 0.52;
    }

    if (animateForward) {
      controller.animateTo(
        1.0,
        duration: _kDroppedSheetDragAnimationDuration,
        curve: animationCurve,
      );
    } else {
      if (isCurrent) {
        // This route is destined to pop at this point. Reuse navigator's pop.
        final NavigatorState rootNavigator = Navigator.of(navigator.context, rootNavigator: true);
        rootNavigator.pop();
      }

      if (controller.isAnimating) {
        controller.animateBack(
          0.0,
          duration: _kDroppedSheetDragAnimationDuration,
          curve: animationCurve,
        );
      }
    }

    if (controller.isAnimating) {
      // Keep the userGestureInProgress in true state so we don't change the
      // curve of the page transition mid-flight since CupertinoPageTransition
      // depends on userGestureInProgress.
      // late AnimationStatusListener animationStatusCallback;
      void animationStatusCallback(AnimationStatus status) {
        navigator.didStopUserGesture();
        controller.removeStatusListener(animationStatusCallback);
      }

      controller.addStatusListener(animationStatusCallback);
    } else {
      navigator.didStopUserGesture();
    }
  }
}