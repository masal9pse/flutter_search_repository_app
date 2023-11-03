import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/response_item_enum.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/molecules/response_icon_count.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/molecules/response_list_tile.dart';

/// 検索結果
class ResponseDetailCard extends StatelessWidget {
  const ResponseDetailCard({
    super.key,
    required this.url,
    required this.title,
    required this.stargazersCount,
    required this.subtitle,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    this.callback,
  });

  final String url;
  final String title;
  final String subtitle;
  final String stargazersCount;
  final String watchersCount;
  final String forksCount;
  final String openIssuesCount;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ResponseListTile(
              image: Image.network(
                url,
                errorBuilder: (_, __, ___) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                  );
                },
              ),
              title: title,
              subtitle: subtitle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ResponseIconCount(
                  icon: ResponseItemEnum.stargazersCount.icon,
                  count: stargazersCount,
                ),
                const SizedBox(width: 8),
                ResponseIconCount(
                  icon: ResponseItemEnum.watchersCount.icon,
                  count: watchersCount,
                ),
                const SizedBox(width: 8),
                ResponseIconCount(
                  icon: ResponseItemEnum.forksCount.icon,
                  count: forksCount,
                ),
                const SizedBox(width: 8),
                ResponseIconCount(
                  icon: ResponseItemEnum.openIssuesCount.icon,
                  count: openIssuesCount,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
