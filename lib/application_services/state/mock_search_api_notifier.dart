import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';

class MockSearchApiNotifier extends SearchApiNotifier {
  @override
  Future<SearchApiModel?> build() async {
    return const SearchApiModel(totalCount: 1, items: [
      Item(
        name: 'ruby',
        stargazersCount: 2,
        language: 'ruby',
        owner: Owner(
          avatarUrl: 'https://avatars.githubusercontent.com/u/84199788?v=4',
        ),
      )
    ]);
  }
}