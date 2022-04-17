import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class TestMultiTapButtonWidget {
  /// テスト用ウィジェットの起動
  MaterialApp testMainViewWidget(Widget widget) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => SearchApiViewModel(), child: widget),
    );
  }
}