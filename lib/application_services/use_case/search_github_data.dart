import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_github_api_repository.dart';

/// GitHubからレポジトリを検索する
class SearchGitHubDataUseCase {
  final SearchApiRepository repository;
  final SearchApiNotifier notifier;

  SearchGitHubDataUseCase({required this.repository, required this.notifier});

  Future<void> searchGitHubData(String searchWord) async {
    await notifier.load();
    final searchResults = await repository.getApiListInfo(input: searchWord);
    await notifier.updateState(searchResults);
  }
}