import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/atoms/images/angle_circle_large_image.dart';
import 'package:flutter_engineer_codecheck/view/atoms/base_image_network.dart';
import 'package:flutter_engineer_codecheck/view/atoms/texts/large_text.dart';
import 'package:flutter_engineer_codecheck/view/atoms/texts/normal_text.dart';

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
        AngleCircleLargeImage(image: BaseImageNetWork.build(url: url)),
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
        NormalText(text: subtitle),
        const Text(
          'スター数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        NormalText(
          text: stargazersCount,
        ),
        const Text(
          'watcher数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        NormalText(
          text: watchersCount,
        ),
        const Text(
          'fork数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        NormalText(
          text: forksCount,
        ),
        const Text(
          'issue数',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        NormalText(
          text: openIssuesCount,
        ),
      ],
    );
  }
}
