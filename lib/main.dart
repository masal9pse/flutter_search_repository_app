import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';
import 'package:flutter_engineer_codecheck/view/search_api_list_view.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchApiViewModel>(
            create: (context) => SearchApiViewModel(SearchApiService())),
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
      home: SearchApiListView(),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{},
    );
  }
}