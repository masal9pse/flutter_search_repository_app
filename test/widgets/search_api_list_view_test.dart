import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/response_message.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';
import 'package:flutter_engineer_codecheck/view/search_api_list_view.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import '../test_data/api_mock_test_data.dart';

class MockSearchApiService extends Mock implements SearchApiService {}

void main() {
  // setUpAll(() => HttpOverrides.global = null);
  group('API一覧ページのテスト', () {
    final mockSearchApiService = MockSearchApiService();

    MaterialApp testMainViewWidget() {
      return MaterialApp(
        home: ChangeNotifierProvider(
            create: (context) => SearchApiViewModel(mockSearchApiService),
            child: SearchApiListView()),
      );
    }

    group('正常系', () {
      testWidgets('検索フォームと検索ボタンがあることをテスト', (WidgetTester tester) async {
        await tester.pumpWidget(testMainViewWidget());
        expect(find.byKey(Key('search_text_field')), findsOneWidget);
        expect(find.byKey(Key('search_elevated_button')), findsOneWidget);
      });

      testWidgets('検索フォームに入力して、検索ボタンをタップすると一覧に表示される。',
          (WidgetTester tester) async {
        await tester.pumpWidget(testMainViewWidget());
        final input = 'testです';
        final apiSuccessTestData01 = ApiMockTestData().apiSuccessTestData01;
        final convertedApiSuccessTestData01 =
            SearchApiModelStruct.fromJson(apiSuccessTestData01);
        when(mockSearchApiService.getApiListInfo(input))
            .thenAnswer((_) => Future.value(convertedApiSuccessTestData01));

        await tester.enterText(find.byKey(Key('search_text_field')), input);
        await tester.tap(find.byKey(Key('search_elevated_button')));
        await tester.pump(Duration(seconds: 1));
        expect(find.text('rep2'), findsOneWidget);
        expect(find.text('Cddddddd'), findsOneWidget);
        expect(find.byKey(Key('snack_bar')), findsOneWidget);
        // verifyを使用
        expectTextData(tester: tester, data: ResponseMessage.successfulMessage);
      });
    });

    group('異常系', () {
      testWidgets('検索フォームに入力して、検索ボタンをタップするとエラーをスローする。', (WidgetTester tester) async {
        await tester.pumpWidget(testMainViewWidget());
        final input = 'testです';
        // when(mockSearchApiService.getApiListInfo(input))
        //     .thenThrow((_) => TimeoutException('タイムアウトが発生しました'));
        // when(mockSearchApiService.getApiListInfo(input))
        //     .thenThrow((_) => Exception('タイムアウトが発生しました'));
        // when(mockSearchApiService.getApiListInfo(input)).thenThrow(Exception);
        when(mockSearchApiService.getApiListInfo(input)).thenAnswer((_) => throw Exception());

        expect(() => mockSearchApiService.getApiListInfo(input), throwsException);
        // await tester.enterText(find.byKey(Key('search_text_field')), input);
        // try {
        // await tester.tap(find.byKey(Key('search_elevated_button')));
        // await tester.pump(Duration(seconds: 1));
        // } on Exception catch (e) {
        //   expect(e, Exception());
        // }
        // expect(find.text('rep2'), findsOneWidget);
        // expect(find.text('Cddddddd'), findsOneWidget);
        // expect(() =>  matcher)
        // expect(find.byKey(Key('snack_bar')), findsOneWidget);
        // expectTextData(tester: tester, data: ResponseMessage.timeoutMessage);
      });
    });
  });
}

void expectTextData({required WidgetTester tester, required String data}) {
  expect(
      ((tester.widget(find.byKey(Key('snack_bar'))) as SnackBar).content
              as Text)
          .data,
      data);
}
