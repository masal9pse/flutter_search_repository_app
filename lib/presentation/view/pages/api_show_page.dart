import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ApiShowRouterPage extends AutoRouter {
  const ApiShowRouterPage({super.key});
}

/// 詳細ページ
@RoutePage()
class ApiShowPage extends ConsumerWidget {
  const ApiShowPage({
    super.key,
    @queryParam this.name = 'masato is god',
    // required this.item,
  });

  final String name;
  // final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final item = ref.watch(searchApiListPageNotifierProvider);
    // final a = context.router.canPop();
    // final b = context.router.maybePop().then((value) {
    //   print(123);
    // });
    // final owner = item.owner;
    // final avatarUrl = owner.avatarUrl;
    // final name = item.name;
    // final language = item.language;
    // final stargazersCount = item.stargazersCount.toString();
    // final watchersCount = item.watchersCount.toString();
    // final forksCount = item.forksCount.toString();
    // final openIssuesCount = item.openIssuesCount.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.showAppBarTitle),
      ),
      body: Center(
        child: Column(
          children: [
            Text('名前は$nameです'),
            ElevatedButton(
              onPressed: () {
                context.router.back(); // ブラウザが表示される
                // Navigator.pop(context); // 何も表示されない
              },
              child: Text('戻る'),
            )
          ],
        ),
      ),
      // body: ResponseShowDetail(
      //   url: avatarUrl,
      //   title: name,
      //   language: language,
      //   stargazersCount: stargazersCount,
      //   watchersCount: watchersCount,
      //   forksCount: forksCount,
      //   openIssuesCount: openIssuesCount,
      // ),
    );
  }
}
