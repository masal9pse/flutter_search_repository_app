import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/presentation/router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      title: PageInfoEnum.top.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
