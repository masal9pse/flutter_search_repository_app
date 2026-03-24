import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/search_repo/core/l10n/github_repo_api_exception_l10n.dart';
import 'package:flutter_engineer_codecheck/search_repo/presentation/providers/repo_search_provider.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'part/_content.dart';
part 'part/_error_scaffold.dart';
part 'part/_info_chip.dart';
part 'part/_loading_scaffold.dart';

class RepoDetailScreen extends ConsumerWidget {
  const RepoDetailScreen({
    required this.owner,
    required this.repo,
    super.key,
  });

  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetail =
        ref.watch(repoDetailProvider((owner: owner, repo: repo)));

    return asyncDetail.when(
      loading: () => _LoadingScaffold(owner: owner, repo: repo),
      data: (item) => _Content(item: item, owner: owner, repo: repo),
      error: (e, _) => _ErrorScaffold(
        owner: owner,
        repo: repo,
        exception: e as GithubRepoApiException,
      ),
    );
  }
}
