import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';


class MockSearchApiService extends Mock implements SearchApiService {}

class SearchApiListViewTestData {
  /// テスト用ウィジェットの起動
  MaterialApp testMainViewWidget(Widget widget) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => SearchApiViewModel(MockSearchApiService()), child: widget),
    );
  }
}