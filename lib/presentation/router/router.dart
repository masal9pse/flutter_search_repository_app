import 'package:auto_route/auto_route.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          children: [
            AutoRoute(
              path: 'home',
              // ページじゃなくてrouteプロパティの方がよくない？
              page: HomeRouterRoute.page,
              children: [
                AutoRoute(initial: true, page: SearchApiListRoute.page),
                AutoRoute(page: FavoriteRoute.page),
              ],
            ),
            AutoRoute(
              path: 'mypage',
              page: MyRoute.page,
            ),
          ],
        ),
        AutoRoute(page: ApiShowRoute.page),
      ];
}
