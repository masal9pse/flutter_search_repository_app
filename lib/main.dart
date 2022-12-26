import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';
import 'package:flutter_engineer_codecheck/view/pages/search_api_list_page.dart';
import 'package:flutter_engineer_codecheck/view/pages/api_show_page.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SearchApiViewModel>(
            create: (context) => SearchApiViewModel(
              SearchApiService(),
            ),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: ((context, state) => SearchApiListPage()),
      ),
      GoRoute(
        path: '/show',
        builder: ((context, state) {
          final item = state.extra as Item;
          return ApiShowPage(
            item: item,
          );
        }),
      ),
    ],
  );

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: 'GithubAPI検索App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
