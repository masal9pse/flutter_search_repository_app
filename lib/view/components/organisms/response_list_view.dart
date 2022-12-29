import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/response_detail_card.dart';
import 'package:go_router/go_router.dart';

class ResponseListView extends StatelessWidget {
  const ResponseListView({
    super.key,
    required this.searchApiModelStruct,
  });

  final SearchApiModelStruct searchApiModelStruct;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchApiModelStruct.items.length,
      itemBuilder: (context, index) {
        final item = searchApiModelStruct.items[index];
        final owner = item.owner;
        final avatarUrl = owner.avatarUrl;
        final name = item.name;
        final language = item.language ?? '';
        final stargazersCount = item.stargazersCount.toString();
        final watchersCount = item.watchersCount.toString();
        final forksCount = item.forksCount.toString();
        final openIssuesCount = item.openIssuesCount.toString();

        return ResponseDetailCard(
          url: avatarUrl,
          title: name,
          subtitle: language,
          stargazersCount: stargazersCount,
          watchersCount: watchersCount,
          forksCount: forksCount,
          openIssuesCount: openIssuesCount,
          callback: () {
            context.push(PageInfoEnum.show.route, extra: item);
          },
        );
      },
    );
  }
}
