import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/response_item_enum.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/images/angle_circle_large_image.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/molecules/response_text.dart';

class ResponseShowDetail extends StatelessWidget {
  const ResponseShowDetail({
    super.key,
    required this.url,
    required this.title,
    required this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
  });

  final String url;
  final String title;
  final String language;
  final String stargazersCount;
  final String watchersCount;
  final String forksCount;
  final String openIssuesCount;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AngleCircleLargeImage(
          image: Image.network(
            url,
            errorBuilder: (_, __, ___) {
              return const Icon(
                Icons.error,
                color: Colors.red,
              );
            },
          ),
        ),
        ResponseText(title: ResponseItemEnum.name.title, titleValue: title),
        const SizedBox(
          height: 10,
        ),
        ResponseText(
          title: ResponseItemEnum.language.title,
          titleValue: language,
        ),
        const SizedBox(
          height: 10,
        ),
        ResponseText(
          title: ResponseItemEnum.stargazersCount.title,
          titleValue: stargazersCount,
        ),
        const SizedBox(
          height: 10,
        ),
        ResponseText(
          title: ResponseItemEnum.watchersCount.title,
          titleValue: watchersCount,
        ),
        const SizedBox(
          height: 10,
        ),
        ResponseText(
          title: ResponseItemEnum.forksCount.title,
          titleValue: forksCount,
        ),
        const SizedBox(
          height: 10,
        ),
        ResponseText(
          title: ResponseItemEnum.openIssuesCount.title,
          titleValue: openIssuesCount,
        ),
      ],
    );
  }
}
