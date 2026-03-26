import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/search_repo/core/l10n/github_repo_api_exception_l10n.dart';
import 'package:flutter_engineer_codecheck/search_repo/presentation/providers/repo_search_provider.dart';
import 'package:flutter_engineer_codecheck/search_repo/presentation/state/repo_search_state.dart';
import 'package:flutter_engineer_codecheck/search_repo/presentation/views/screens/repo_detail_screen.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'part/_exception_view.dart';
part 'part/_initial_view.dart';
part 'part/_repo_list.dart';
part 'part/_repo_list_item.dart';
part 'part/_search_form.dart';
part 'part/_search_result.dart';

class RepoSearchScreen extends ConsumerWidget {
  const RepoSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub リポジトリ検索'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SearchForm(),
          Divider(height: 1),
          Expanded(child: _SearchResult()),
        ],
      ),
    );
  }
}
