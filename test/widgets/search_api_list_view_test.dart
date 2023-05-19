import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/di/search_api_repository_provider.dart';
import 'package:flutter_engineer_codecheck/application/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/infrastructure/fake_search_api_client.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('API一覧ページのテスト', () {
    MaterialApp testMainViewWidget() {
      return MaterialApp(
        home: SearchApiListPage(),
      );
    }

    group('正常系', () {
      testWidgets('検索フォームと検索ボタンがあることをテスト', (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchApiRepositoryProvider
                  .overrideWithValue(FakeSearchApiRepositoryImpl())
            ],
            child: testMainViewWidget(),
          ),
        );
        expect(find.byKey(AppKeyName.topPageSearchTextField), findsOneWidget);
        expect(find.byKey(AppKeyName.searchElevatedButton), findsOneWidget);
      });

      testWidgets('検索フォームに入力して、検索ボタンをタップすると一覧に表示される。',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchApiRepositoryProvider
                  .overrideWithValue(FakeSearchApiRepositoryImpl())
            ],
            child: testMainViewWidget(),
          ),
        );
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
      });
    });

    group('異常系', () {
      testWidgets('検索ボタンをタップするとsnackbarに例外のメッセージが表示されることをテスト',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchApiRepositoryProvider
                  .overrideWithValue(FakeErrorSearchApiRepositoryImpl())
            ],
            child: testMainViewWidget(),
          ),
        );
        const input = 'PHP';

        await tester.enterText(
          find.byKey(AppKeyName.topPageSearchTextField),
          input,
        );
        await tester.tap(
          find.byKey(AppKeyName.searchElevatedButton),
        );
        await tester.pumpAndSettle();
        expect(find.text('インターネットに接続できませんでした'), findsOneWidget);
      });
    });
  });
}
