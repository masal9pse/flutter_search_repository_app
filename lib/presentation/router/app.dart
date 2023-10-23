import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SearchApiListPage(),
    );
  }
}
