import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';
import 'package:flutter_engineer_codecheck/view/search_api_list_page.dart';
import 'package:flutter_engineer_codecheck/view/show/api_show_page.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

void main() {
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
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GithubAPI検索App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SearchApiListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/show') {
          return MaterialPageRoute(
            builder: (context) => ApiShowPage(item: settings.arguments as Item?),
          );
        }
        return null;
      },
    );
  }
}
