import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/application/di/infurastructure.dart';
import 'package:flutter_engineer_codecheck/application/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_fake_api_repository.dart';
import 'package:flutter_engineer_codecheck/presentation/router/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  Widget testMainViewWidget() {
    return const App();
  }

  testWidgets('正常系_一覧表示画面のテスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          searchApiRepositoryProvider
              .overrideWithValue(SearchFakeApiRepository())
        ],
        child: testMainViewWidget(),
      ),
    );

    // タイトル、テキストフォーム、検索実行ボタンが表示されていること
    expect(find.text(PageInfoEnum.top.title), findsOneWidget);
    expect(find.byKey(AppKeyName.topPageSearchTextField), findsOneWidget);
    expect(find.byKey(AppKeyName.searchElevatedButton), findsOneWidget);

    // テキストフォームにキーワードを入力して、ボタンを押すと検索結果が更新されること
    await tester.enterText(
      find.byKey(AppKeyName.topPageSearchTextField),
      'Go language',
    );
    await tester.tap(
      find.byKey(AppKeyName.searchElevatedButton),
    );
    await tester.pumpAndSettle();
    expect(find.text('やまもとまさと'), findsOneWidget);

    // 検索結果をタップすると、詳細画面に遷移することを確認
    await tester.tap(
      find.byKey(AppKeyName.responseDetailCard(0)),
    );
    await tester.pumpAndSettle();
    expect(find.text(PageInfoEnum.show.title), findsOneWidget);
  });

  testWidgets('異常系_一覧表示画面のテスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          searchApiRepositoryProvider
              .overrideWithValue(SearchFakeErrorApiRepository())
        ],
        child: testMainViewWidget(),
      ),
    );
    const input = 'PHP';

    // テキストフォームにキーワードを入力して、ボタンを押すと検索結果が更新されないケースがあること
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
}
