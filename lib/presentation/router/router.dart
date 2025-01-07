import 'package:auto_route/auto_route.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SearchApiListRoute.page, initial: true),
        AutoRoute(page: ApiShowRoute.page),
    ];
}