import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/application/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/application/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/application/di/infrastructure.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_fake_api_repository.dart';
import 'package:flutter_engineer_codecheck/presentation/router/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('API一覧ページのテスト', () {
    Widget testMainViewWidget() {
      return const App();
    }

    const searchWord = 'Dart';

    group('正常系', () {
      testWidgets('一覧表示画面_読み込み時のテスト',
          (WidgetTester tester) async {
        await tester.runAsync(() async {
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                searchApiRepositoryProvider.overrideWithValue(
                  SearchFakeApiRepository(),
                ),
              ],
              child: testMainViewWidget(),
            ),
          );

          expect(find.text(PageInfoEnum.top.title), findsOneWidget);
          expect(find.byKey(AppKeyName.topPageSearchTextField), findsOneWidget);
          expect(find.byKey(AppKeyName.searchElevatedButton), findsOneWidget);
          expect(find.byKey(AppKeyName.responseDetailCard(0)), findsNothing);
        });
      });

      testWidgets('検索フォームに入力して、検索ボタンをタップすると一覧に表示される。',
          (WidgetTester tester) async {
        await tester.runAsync(
          () async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  searchApiRepositoryProvider.overrideWithValue(
                    SearchFakeApiRepository(),
                  ),
                ],
                child: testMainViewWidget(),
              ),
            );

            await tester.enterText(
              find.byKey(AppKeyName.topPageSearchTextField),
              searchWord,
            );
            await tester.tap(
              find.byKey(AppKeyName.searchElevatedButton),
            );
            await tester.pumpAndSettle();
            expect(
              find.byKey(AppKeyName.responseDetailCard(0)),
              findsOneWidget,
            );
            expect(
              find.byKey(AppKeyName.responseDetailCard(7)),
              findsOneWidget,
            );
            expect(
              find.byKey(AppKeyName.responseDetailCard(8)),
              findsNothing,
            );
            await tester.tap(
              find.byKey(AppKeyName.responseDetailCard(0)),
            );
            await tester.pumpAndSettle();
            expect(find.text(PageInfoEnum.show.title), findsOneWidget);
          },
        );
      });

      testWidgets('項目をタップすると、詳細画面に遷移すること',
          (WidgetTester tester) async {
        await tester.runAsync(
          () async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  searchApiRepositoryProvider.overrideWithValue(
                    SearchFakeApiRepository(),
                  ),
                ],
                child: testMainViewWidget(),
              ),
            );

            await tester.enterText(
              find.byKey(AppKeyName.topPageSearchTextField),
              searchWord,
            );
            await tester.tap(
              find.byKey(AppKeyName.searchElevatedButton),
            );
            await tester.pumpAndSettle();
            await tester.tap(
              find.byKey(AppKeyName.responseDetailCard(0)),
            );
            await tester.pumpAndSettle();
            expect(find.text(PageInfoEnum.show.title), findsOneWidget);
          },
        );
      });
    });

    group('異常系', () {
      testWidgets('検索ボタンをタップするとsnackbarに例外のメッセージが表示されることをテスト',
          (WidgetTester tester) async {
        await tester.runAsync(
          () async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  searchApiRepositoryProvider.overrideWithValue(
                    SearchFakeErrorApiRepository(),
                  ),
                ],
                child: testMainViewWidget(),
              ),
            );

            await tester.enterText(
              find.byKey(AppKeyName.topPageSearchTextField),
              searchWord,
            );
            await tester.tap(
              find.byKey(AppKeyName.searchElevatedButton),
            );
            await tester.pumpAndSettle();
            expect(
              find.text(ResponseEnum.noConnection.message),
              findsOneWidget,
            );
          },
        );
      });
    });
  });
}
