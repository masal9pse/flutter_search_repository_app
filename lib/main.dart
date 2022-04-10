import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/search_api_list_view.dart';

void main() {
  runApp(MyApp());
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