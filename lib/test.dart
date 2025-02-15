import 'package:flutter/widgets.dart';

void main() {
  classA obj = classA(data: 100);
  print(obj.data); // 100 を出力
}

class classA extends classB {

  // @override
  // // TODO: implement data
  // int get data => 10;
  // classA({required this.data});
  // classA({this.data = 3});
  classA({this.data});
  @override
  final int? data;
}

abstract class classB extends classC {
  classB() {
    print('classB');
  }
}

abstract class classC {
  // int? get data;
  int? get data;
}

Widget _defaultTransitionsBuilder(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  return child;
}

class PageRouteBuilder2<T> extends PageRoute<T> {
  /// Creates a route that delegates to builder callbacks.
  PageRouteBuilder2({
    super.settings,
    super.requestFocus,
    required this.pageBuilder,
    this.transitionsBuilder = _defaultTransitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    super.fullscreenDialog,
    super.allowSnapshotting = true,
  });

  /// {@template flutter.widgets.pageRouteBuilder.pageBuilder}
  /// Used build the route's primary contents.
  ///
  /// See [ModalRoute.buildPage] for complete definition of the parameters.
  /// {@endtemplate}
  final RoutePageBuilder pageBuilder;

  /// {@template flutter.widgets.pageRouteBuilder.transitionsBuilder}
  /// Used to build the route's transitions.
  ///
  /// See [ModalRoute.buildTransitions] for complete definition of the parameters.
  /// {@endtemplate}
  ///
  /// The default transition is a jump cut (i.e. no animation).
  final RouteTransitionsBuilder transitionsBuilder;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return transitionsBuilder(context, animation, secondaryAnimation, child);
  }
}
