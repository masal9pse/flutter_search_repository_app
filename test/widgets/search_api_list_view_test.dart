import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/application/di/infurastructure.dart';
import 'package:flutter_engineer_codecheck/application/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_fake_api_repository.dart';
import 'package:flutter_engineer_codecheck/presentation/router/app.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('API一覧ページのテスト', () {
    MaterialApp testMainViewWidget() {
      return const MaterialApp(
        home: App(),
      );
    }

    group('正常系', () {
      testWidgets('検索フォームと検索ボタンがあることをテスト', (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchApiRepositoryProvider
                  .overrideWith((ref) => SearchFakeApiRepository()),
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
                  .overrideWith((ref) => SearchFakeApiRepository()),
            ],
            child: testMainViewWidget(),
          ),
        );

        await tester.enterText(
          find.byKey(AppKeyName.topPageSearchTextField),
          'Go language',
        );
        await tester.tap(
          find.byKey(AppKeyName.searchElevatedButton),
        );
        await tester.pumpAndSettle();
        expect(find.text('やまもとまさと'), findsOneWidget);
      });

      testWidgets('検索結果が反映されている状態で、その項目をタップすると詳細画面に遷移する',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchApiRepositoryProvider
                  .overrideWith((ref) => SearchFakeApiRepository()),
            ],
            child: testMainViewWidget(),
          ),
        );
        await tester.enterText(
          find.byKey(AppKeyName.topPageSearchTextField),
          'Go language',
        );
        await tester.tap(
          find.byKey(AppKeyName.searchElevatedButton),
        );

        await tester.pumpAndSettle();
        expect(find.text('やまもとまさと'), findsOneWidget);

        await tester.tap(
          find.byKey(AppKeyName.responseDetailCard(0)),
        );
        await tester.pumpAndSettle();
        expect(find.text(PageInfoEnum.show.title), findsOneWidget);
      });
    });

    group('異常系', () {
      testWidgets('検索ボタンをタップするとsnackbarに例外のメッセージが表示されることをテスト',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              searchApiRepositoryProvider
                  .overrideWith((ref) => SearchFakeErrorApiRepository()),
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
