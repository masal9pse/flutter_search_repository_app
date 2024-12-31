import 'package:flutter_engineer_codecheck/application_services/di/infrastructure.dart';
import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application_services/use_case/search_github_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchGitHubDataUseCaseProvider = Provider.autoDispose<SearchGitHubDataUseCase>(
  (ref) {
    final notifier = ref.watch(searchApiNotifierProvider.notifier);
    final repository = ref.watch(searchApiRepositoryProvider);
    return SearchGitHubDataUseCase(
      repository: repository,
      notifier: notifier,
    );
  },
);
