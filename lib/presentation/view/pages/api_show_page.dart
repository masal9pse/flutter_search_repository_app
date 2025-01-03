import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/response_show_detail.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 詳細ページ
class ApiShowPage extends ConsumerWidget {
  const ApiShowPage({
    super.key,
    // required this.id,
    required this.item,
  });

  // final int id;
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final item = ref.watch(searchApiListPageNotifierProvider);
    final owner = item.owner;
    final avatarUrl = owner.avatarUrl;
    final name = item.name;
    final language = item.language;
    final stargazersCount = item.stargazersCount.toString();
    final watchersCount = item.watchersCount.toString();
    final forksCount = item.forksCount.toString();
    final openIssuesCount = item.openIssuesCount.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.showAppBarTitle),
      ),
      body: ResponseShowDetail(
        url: avatarUrl,
        title: name,
        language: language,
        stargazersCount: stargazersCount,
        watchersCount: watchersCount,
        forksCount: forksCount,
        openIssuesCount: openIssuesCount,
      ),
    );
  }
}
