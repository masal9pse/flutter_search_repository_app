// ignore_for_file: avoid_print

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class MyObserver extends AutoRouterObserver {

  @override
  void didPush(Route route, Route? previousRoute) {
    print('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    print('this is pop');
    super.didPop(route, previousRoute);
  }

 // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('Tab route re-visited: ${route.name}');
  }
}