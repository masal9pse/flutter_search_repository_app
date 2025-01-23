import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/create_issue_code.gr.dart';

void main() {
  runApp(App());
}

final _appRouter = AppRouter();

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: BoardRouterRoute.page,
          children: [
            AutoRoute(
              page: FirstRouterRoute.page,
              children: [
                AutoRoute(
                  initial: true,
                  page: FirstRoute.page,
                ),
                // AutoRoute(page: FirstDetailRoute.page),
              ],
            ),
            AutoRoute(
              page: SecondRoute.page,
            ),
          ],
        ),
        AutoRoute(page: FirstDetailRoute.page),
      ];
}

@RoutePage()
class BoardRouterPage extends StatelessWidget {
  const BoardRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        FirstRoute(),
        SecondRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(label: 'first', icon: Text('first')),
            BottomNavigationBarItem(label: 'second', icon: Text('second')),
          ],
        );
      },
    );
  }
}

@RoutePage()
class FirstRouterPage extends AutoRouter {
  const FirstRouterPage({super.key});
}

@RoutePage()
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.push(FirstDetailRoute());
              },
              child: Text('go to First detail page'),
            ),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class FirstDetailPage extends StatelessWidget {
  const FirstDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Detail Page'),
      ),
    );
  }
}

@RoutePage()
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second page'),
      ),
    );
  }
}
