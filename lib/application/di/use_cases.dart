import 'package:flutter_engineer_codecheck/application/di/search_api_repository_provider.dart';
import 'package:flutter_engineer_codecheck/application/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application/use_case/search_github_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchGitHubDataProvider = Provider.autoDispose<SearchGitHubDataUseCase>(
  (ref) {
    final notifier = ref.watch(searchApiNotifierProvider.notifier);
    final repository = ref.watch(searchApiRepositoryProvider);
    return SearchGitHubDataUseCase(
      repository: repository,
      notifier: notifier,
    );
  },
);
