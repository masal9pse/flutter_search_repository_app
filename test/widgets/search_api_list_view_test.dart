// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_engineer_codecheck/const/app_key_name.dart';
// import 'package:flutter_engineer_codecheck/const/enum/response_enum.dart';
// import 'package:flutter_engineer_codecheck/model/api_error.dart';
// import 'package:flutter_engineer_codecheck/model/result.dart';
// import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
// import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
// import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
// import 'package:flutter_engineer_codecheck/view/pages/search_api_list_page.dart';
// import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import '../test_data/api_mock_test_data.dart';

// class MockSearchApiService extends Mock implements SearchApiRepository {}

// void main() {
//   setUpAll(() => HttpOverrides.global = null);
//   group('API一覧ページのテスト', () {
//     final mockSearchApiService = MockSearchApiService();

//     MaterialApp testMainViewWidget() {
//       return MaterialApp(
//         home: ChangeNotifierProvider(
//           create: (context) =>
//               SearchApiNotifier(searchApiRepository: mockSearchApiService),
//           child: SearchApiListPage(),
//         ),
//       );
//     }

//     group('正常系', () {
//       testWidgets('検索フォームと検索ボタンがあることをテスト', (WidgetTester tester) async {
//         await tester.pumpWidget(testMainViewWidget());
//         expect(find.byKey(AppKeyName.topPageSearchTextField), findsOneWidget);
//         expect(find.byKey(AppKeyName.searchElevatedButton), findsOneWidget);
//       });

//       testWidgets('検索フォームに入力して、検索ボタンをタップすると一覧に表示される。',
//           (WidgetTester tester) async {
//         await tester.pumpWidget(testMainViewWidget());
//         const input = 'Go language';
//         final apiSuccessTestData01 = ApiMockTestData().apiSuccessTestData01;
//         final convertedApiSuccessTestData01 =
//             SearchApiModelStruct.fromJson(apiSuccessTestData01);
//         when(mockSearchApiService.getApiListInfo(input: input)).thenAnswer(
//           (_) => Future.value(Result.success(convertedApiSuccessTestData01)),
//         );

//         await tester.enterText(
//           find.byKey(AppKeyName.topPageSearchTextField),
//           input,
//         );
//         await tester.tap(
//           find.byKey(AppKeyName.searchElevatedButton),
//         );
//         await tester.pumpAndSettle();
//         expect(find.text('やまもとまさと'), findsOneWidget);
//         expect(find.text('鈴木大輔'), findsOneWidget);
//       });
//     });

//     group('異常系', () {
//       testWidgets('検索ボタンをタップするとsnackbarに例外のメッセージが表示されることをテスト',
//           (WidgetTester tester) async {
//         await tester.pumpWidget(testMainViewWidget());
//         const input = 'PHP';
//         when(mockSearchApiService.getApiListInfo(input: input)).thenAnswer(
//           (_) => Future.value(
//             Result.failure(
//               ApiError(
//                 code: ResponseEnum.noConnection.status,
//                 message: ResponseEnum.noConnection.message,
//               ),
//             ),
//           ),
//         );

//         await tester.enterText(
//           find.byKey(AppKeyName.topPageSearchTextField),
//           input,
//         );
//         await tester.tap(
//           find.byKey(AppKeyName.searchElevatedButton),
//         );
//         await tester.pumpAndSettle();
//         expect(find.text('インターネットに接続できませんでした'), findsOneWidget);
//       });
//     });
//   });
// }
