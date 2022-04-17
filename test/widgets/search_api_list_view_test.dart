import 'package:flutter/material.dart';
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
      });
    });
  });
}