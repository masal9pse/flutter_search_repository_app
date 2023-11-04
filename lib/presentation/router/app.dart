import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';

import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'top_page',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: const SearchApiListPage(),
        );
      },
    ),
    GoRoute(
      path: '/show',
      name: 'show_page',
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          child: ApiShowPage(id: state.extra as int),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  ),
);

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
