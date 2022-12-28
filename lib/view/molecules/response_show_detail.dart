import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/atoms/circle_large_image.dart';
import 'package:flutter_engineer_codecheck/view/atoms/large_text.dart';

class ResponseShowDetail extends StatelessWidget {
  const ResponseShowDetail({
    super.key,
    required this.url,
    required this.title,
    required this.subtitle,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
  });

  final String url;
  final String title;
  final String subtitle;
  final String stargazersCount;
  final String watchersCount;
  final String forksCount;
  final String openIssuesCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleLargeImage(image: Image.network(url)),
        LargeText(
          title: title,
        ),
        const Text(
          '言語',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        Text(
          subtitle,
        ),
        const Text(
          'スター数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        Text(
          stargazersCount,
        ),
        const Text(
          'watcher数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        Text(
          watchersCount,
        ),
        const Text(
          'fork数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        Text(
          forksCount,
        ),
        const Text(
          'issue数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        Text(
          openIssuesCount,
        ),
      ],
    );
  }
}
