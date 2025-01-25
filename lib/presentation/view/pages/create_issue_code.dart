import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/create_issue_code.gr.dart';

void main() {
  runApp(App());
}

final _appRouter = AppRouter();

class B extends NestedStackRouter {
  B({required super.routeCollection, required super.key, required super.routeData, required super.parent});
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}

class C extends AppRouter {
  
}
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TopRoute.page, initial: true),
        AutoRoute(
          page: MyShellRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'users'),
            AutoRoute(page: UsersRoute.page),
            AutoRoute(page: PostsRoute.page),
          ],
        ),
        AutoRoute(
          path: '/',
          page: BoardRouterRoute.page,          
          children: [
            AutoRoute(
              page: FirstRouterRoute.page,
              children: [
                AutoRoute(
                  page: FirstRoute.page,
                ),
                AutoRoute(page: FirstDetailRoute.page),
              ],
            ),
            AutoRoute(
              page: SecondRoute.page,
            ),
          ],
        ),
        // AutoRoute(page: FirstDetailRoute.page),
      ];
}

@RoutePage()
class TopPage extends StatelessWidget {
  const TopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // context.router.push(FirstRoute());
                // context.router.navigate(BoardRouterRoute(children: [
                //   FirstRouterRoute(children: [FirstRoute()])
                // ]));

                // Top -> Firstになるはず？？？
                // context.router.root.push(FirstRoute()); // ダメだった
                context.router.root.push(BoardRouterRoute(children: [FirstRouterRoute(
                  children: [FirstRoute()]
                )]));

              },
              child: Text('go to First detail page'),
            ),
            ElevatedButton(
              onPressed: () {
                context.router.push(UsersRoute());
              },
              child: Text('go to users'),
            ),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class MyShellPage extends AutoRouter {
  const MyShellPage({super.key});
}

@RoutePage()
class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AutoLeadingButton(),
        title: const Text('users'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => context.router.push(PostsRoute()), child: Text('go to posts')),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class PostsPage extends StatelessWidget {
  const PostsPage({super.key, this.id = -1});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('posts'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(id.toString()),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class BoardRouterPage extends StatelessWidget {
  const BoardRouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        FirstRouterRoute(),
        SecondRoute(),
      ],
      // appBarBuilder: (context, tabsRouter) {
      //   return AppBar(
      //     leading: AutoLeadingButton(),
      //     title: Text(context.topRoute.name),
      //   );
      // },
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(label: '', icon: Text('first')),
            BottomNavigationBarItem(label: '', icon: Text('second')),
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
        // leading: BackButton(onPressed: context.router.maybePop,),
        leading: AutoLeadingButton(
          // showIfParentCanPop: false,
          // showIfChildCanPop: false,
          // ignorePagelessRoutes: true,
          // color: Colors.amber,
        ),
        // leading: AutoLeadingButton(
        //   showIfParentCanPop: false,
        //   showIfChildCanPop: false,
        //   ignorePagelessRoutes: true,
        //   // builder: (context, leadingType, action) {

        //   // },
        // ),
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.router.push(FirstDetailRoute());
                
                // Top -> FirstRouteになるはず？？？
                // context.router.root.push(FirstDetailRoute());
              },
              child: Text('go to First detail page'),
            ),
            BackButton(),
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
