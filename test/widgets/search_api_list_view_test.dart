import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';
import 'package:flutter_engineer_codecheck/view/pages/search_api_list_page.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../test_data/api_mock_test_data.dart';

class MockSearchApiService extends Mock implements SearchApiService {}

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('API一覧ページのテスト', () {
    final mockSearchApiService = MockSearchApiService();

    MaterialApp testMainViewWidget() {
      return MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => SearchApiViewModel(mockSearchApiService),
          child: SearchApiListPage(),
        ),
      );
    }

    void expectTextData({
      required WidgetTester tester,
      required String data,
    }) {
      expect(
        ((tester.widget(
          find.byKey(AppKeyName.snackBar),
        ) as SnackBar)
                .content as Text)
            .data,
        data,
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
        final apiSuccessTestData01 = ApiMockTestData().apiSuccessTestData01;
        final convertedApiSuccessTestData01 =
            SearchApiModelStruct.fromJson(apiSuccessTestData01);
        // なぜかgetApiListInfoの返り値をオプショナルにしたらテストが通った。
        when(mockSearchApiService.getApiListInfo(input: input)).thenAnswer(
          (_) => Future.value(Result.success(convertedApiSuccessTestData01)),
        );

        await tester.enterText(
          find.byKey(AppKeyName.topPageSearchTextField),
          input,
        );
        await tester.tap(
          find.byKey(AppKeyName.searchElevatedButton),
        );
        await tester.pump(const Duration(seconds: 1));
        expect(find.text('やまもとまさと'), findsOneWidget);
        expect(find.text('鈴木大輔'), findsOneWidget);
        expect(find.byKey(AppKeyName.snackBar), findsOneWidget);
        expectTextData(tester: tester, data: ResponseEnum.success.message);
      });
    });

    group('異常系', () {
      testWidgets('検索ボタンをタップするとsnackbarに例外のメッセージが表示されることをテスト',
          (WidgetTester tester) async {
        await tester.pumpWidget(testMainViewWidget());
        const input = 'PHP';
        when(mockSearchApiService.getApiListInfo(input: input)).thenAnswer(
          (_) => Future.value(
            Result.failure(
              ApiError(
                code: ResponseEnum.noConnection.status,
                message: ResponseEnum.noConnection.message,
              ),
            ),
          ),
        );

        await tester.enterText(
          find.byKey(AppKeyName.topPageSearchTextField),
          input,
        );
        await tester.tap(
          find.byKey(AppKeyName.searchElevatedButton),
        );
        await tester.pump(
          const Duration(seconds: 1),
        );
        expect(find.byKey(AppKeyName.snackBar), findsOneWidget);
        expectTextData(
          tester: tester,
          data: ResponseEnum.noConnection.message,
        );
      });
    });
  });
}
