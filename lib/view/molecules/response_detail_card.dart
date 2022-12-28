import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/molecules/response_count.dart';
import 'package:flutter_engineer_codecheck/view/molecules/response_list_tile.dart';

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
            ResponseListTile(url: url, title: title, subtitle: subtitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ResponseCount(icon: Icons.star, count: stargazersCount),
                const SizedBox(width: 8),
                ResponseCount(
                  icon: Icons.remove_red_eye,
                  count: watchersCount,
                ),
                const SizedBox(width: 8),
                ResponseCount(icon: Icons.food_bank_sharp, count: forksCount),
                const SizedBox(width: 8),
                ResponseCount(icon: Icons.report, count: openIssuesCount),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
