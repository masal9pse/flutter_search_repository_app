import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_fake_api_service.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/view/pages/search_api_list_page.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

class MockSearchApiService extends Mock implements SearchApiRepository {}

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('API一覧ページのテスト', () {

    MaterialApp testMainViewWidget() {
      return MaterialApp(
        home: MultiProvider(
          providers: [
            Provider(
              create: (_) => SearchFakeApiService(),
            ),
            ChangeNotifierProvider(
              create: (_) => TextEditingController(),
              child: SearchApiListPage(),
            ),
            StateNotifierProvider<SearchApiViewModel, SearchApiModelStruct>(
              create: (context) => SearchApiViewModel(
                searchApiRepository: context.read<SearchFakeApiService>(),
              ),
              child: SearchApiListPage(),
            ),
          ],
          child: SearchApiListPage(),
        ),
      );
    }

    group('正常系', () {
      testWidgets('検索フォームと検索ボタンがあることをテスト', (WidgetTester tester) async {
        await tester.pumpWidget(testMainViewWidget());
        expect(find.byKey(AppKeyName.topPageSearchTextField), findsOneWidget);
        expect(find.byKey(AppKeyName.searchElevatedButton), findsOneWidget);
      });

      testWidgets('検索フォームに入力して、検索ボタンをタップすると一覧に表示される。',
          (WidgetTester tester) async {
        await tester.pumpWidget(testMainViewWidget());
        const input = 'Go language';

        await tester.enterText(
          find.byKey(AppKeyName.topPageSearchTextField),
          input,
        );
        await tester.tap(
          find.byKey(AppKeyName.searchElevatedButton),
        );
        await tester.pumpAndSettle();
        expect(find.text('やまもとまさと'), findsOneWidget);
        expect(find.text('Item 7'), findsOneWidget);
      });
    });
  });
}
