import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/response_show_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 詳細ページ
class ApiShowPage extends ConsumerWidget {
  const ApiShowPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(searchApiNotifierProvider).value!.items[id];
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
        title: Text(PageInfoEnum.show.title),
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
