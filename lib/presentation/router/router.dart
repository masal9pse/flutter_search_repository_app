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
              page: HomeRouterRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: SearchApiListRoute.page,
                ),
                // TODO: webで直接リンクから詳細画面に遷移する際に、戻るボタンを押すと一覧画面に遷移したい。
                AutoRoute(
                    page: ApiShowRoute.page), // 遷移するが、一覧と同じ階層なので戻る対応はできない。
                // SearchApiListRoute >> ApiShowRoute
                AutoRoute(page: FavoriteRoute.page),
              ],
            ),
            AutoRoute(
              path: 'mypage',
              page: MyRoute.page,
            ),
          ],
        ),
        // AutoRoute(page: ApiShowRoute.page)
        // RootRoute >> ApiShowRoute
        // 親ルーターとして、RootStackRooterを取得する、RootStackRooterから子ルータを見つけられる。
        //　つまりぶら下がっているのはRootRoute >> ApiShowRoute、router.stackで確認できる。
        AutoRoute(
          path: '/dashboard',
          page: DashboardRoute.page,
          children: [
            // AutoRoute(path: 'users', page: UsersRoute.page,initial: true),
            AutoRoute(path: 'users', page: UsersRoute.page),
            // AutoRoute(path: 'posts', page: PostsRoute.page),
            AutoRoute(path: 'posts', page: PostsRoute.page,initial: true),
            // AutoRoute(path: 'settings', page: SettingsRoute.page),
          ],
        ),
        // AutoRoute(path: '/login', page: LoginRoute.page),
        AutoRoute(
          path: '*',
          page: UnknownRoute.page,
        ),
      ];
}
