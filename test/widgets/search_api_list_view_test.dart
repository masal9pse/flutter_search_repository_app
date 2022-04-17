import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/search_api_list_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_data/search_api_list_view_test_data.dart';

void main() {
  group('API一覧ページのテスト', () {
    late TestMultiTapButtonWidget testMultiTapButtonWidget;    
    setUpAll(() {
      testMultiTapButtonWidget = TestMultiTapButtonWidget();
      // usingDeviceWidth = 300;
    });

    group('正常系', () {
      testWidgets('検索フォームと検索ボタンがあることをテスト', (WidgetTester tester) async {
         await tester.pumpWidget(testMultiTapButtonWidget
            .testMainViewWidget(SearchApiListView()));
          expect(find.byKey(Key('search_text_field')), findsOneWidget);
          expect(find.byKey(Key('search_elevated_button')), findsOneWidget);
      });
      testWidgets('検索フォームに入力して、検索ボタンをタップすると一覧に表示される。', (WidgetTester tester) async {
      });
    });
  });
}
