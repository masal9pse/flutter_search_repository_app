import 'package:flutter_engineer_codecheck/application/di/search_api_repository_provider.dart';
import 'package:flutter_engineer_codecheck/application/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/infrastructure/fake_search_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('データが取得できることをテスト', () async {
    final container = ProviderContainer(
      overrides: [
        searchApiRepositoryProvider
            .overrideWithValue(FakeSearchApiRepositoryImpl())
      ],
    );
    expect(
      container.read(searchApiNotifierProvider),
      const AsyncValue<SearchApiModelStruct?>.loading(),
    );
    // Wait for the request to finish
    await Future<void>.value();

    final data = await container.read(searchApiRepositoryProvider).getApiListInfo(input: 'php');
    expect(data!.items.first.name,'やまもとまさと');
    expect(
      data,
      isA<SearchApiModelStruct?>()
          .having((entity) => entity!.totalCount, 'totalCount', 10)
          .having((entity) => entity!.items.first.name, 'name', 'やまもとまさと')
          .having((entity) => entity!.items[1].name, 'name', '鈴木大輔'),
    );
  });
}
