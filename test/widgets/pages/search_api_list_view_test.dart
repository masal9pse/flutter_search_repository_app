import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/application_services/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/application_services/di/infrastructure.dart';
import 'package:flutter_engineer_codecheck/application_services/state/mock_search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_fake_api_repository.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('トップページのテスト', () {
    Widget testMainViewWidget() {
      return const MaterialApp(
        home: SearchApiListPage(),
      );
    }

    const searchWord = 'Dart';

    group('正常系', () {
      testWidgets('読み込み時にタイトル、フォーム、ボタンが表示されていることと項目が１つも表示されていないこと',
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

      testWidgets('項目をタップすると、詳細画面に遷移すること', (WidgetTester tester) async {
        await tester.runAsync(
          () async {
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  searchApiNotifierProvider.overrideWith(() => MockSearchApiNotifier()),
                ],
                child: testMainViewWidget(),
              ),
            );
            await tester.pumpAndSettle();            
            await tester.tap(
              find.byKey(AppKeyName.responseDetailCard(0)),
            );
            await tester.pumpAndSettle();
            expect(find.text(PageInfoEnum.show.title), findsOneWidget);
            expect(find.text(SearchApiModel.mockData.items.first.name), findsOneWidget);
            expect(find.text(SearchApiModel.mockData.items.first.language), findsOneWidget);
            expect(find.text(SearchApiModel.mockData.items[1].language), findsNothing);
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
