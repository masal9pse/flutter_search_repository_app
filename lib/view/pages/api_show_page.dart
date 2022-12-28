import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/view/molecules/response_show_detail.dart';

class ApiShowPage extends StatelessWidget {
  ApiShowPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;
  late final owner = item.owner;
  late final avatarUrl = owner.avatarUrl;
  late final name = item.name;
  late final language = item.language ?? '';
  late final stargazersCount = item.stargazersCount.toString();
  late final watchersCount = item.watchersCount.toString();
  late final forksCount = item.forksCount.toString();
  late final openIssuesCount = item.openIssuesCount.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('詳細ページ'),
      ),
      body: ResponseShowDetail(
        url: avatarUrl,
        title: name,
        subtitle: language,
        stargazersCount: stargazersCount,
        watchersCount: watchersCount,
        forksCount: forksCount,
        openIssuesCount: openIssuesCount,
      ),
    );
  }
}
