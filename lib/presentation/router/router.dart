import 'package:auto_route/auto_route.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/swipe_router.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/upper_dashboard_page.dart';

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
              // ページ(ルート)を使っているのかルーターを使っているか今のコードだと分かりづらいな。
              page: HomeRouterRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: SearchApiListRoute.page,
                ),
                // TODO: webで直接リンクから詳細画面に遷移する際に、戻るボタンを押すと一覧画面に遷移したい。
                AutoRoute(
                  page: ApiShowRoute.page,
                ), // 遷移するが、一覧と同じ階層なので戻る対応はできない。
                AutoRoute(page: FavoriteRoute.page),
              ],
            ),
            AutoRoute(
              // path: 'mypage',
              page: MyRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: DashboardRouterRoute.page,
          children: [
            AutoRoute(page: UsersRoute.page),
            AutoRoute(page: PostsRoute.page),
          ],
        ),
        AutoRoute(
          page: SwipeRoute.page,
          children: [
            AutoRoute(page: BooksTab.page),
            AutoRoute(page: ProfileTab.page),
          ],
        ),
        AutoRoute(
          page: UpperDashboardRouterRoute.page,
          children: [
            AutoRoute(page: BooksTab.page),
            AutoRoute(page: ProfileTab.page),
            AutoRoute(page: SettingsTab.page),
          ],
        ),
      ];
}
