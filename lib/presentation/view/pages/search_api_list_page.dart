import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/config/app_error_message.dart';
import 'package:flutter_engineer_codecheck/application_services/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/application_services/state/form_key_provider.dart';
import 'package:flutter_engineer_codecheck/application_services/state/search_api_list_page_notifier.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/domain/model/app_state.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
import 'package:flutter_engineer_codecheck/presentation/theme_extention.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/texts/normal_text.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/response_detail_card.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/search_bar.dart'
    as search;
import 'package:flutter_engineer_codecheck/presentation/view/pages/swipe_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class HomeRouterPage extends AutoRouter {
  const HomeRouterPage({super.key});
}

/// トップページ
@RoutePage()
class SearchApiListPage extends HookConsumerWidget {
  const SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final searchApiListPageState = ref.watch(searchApiListPageNotifierProvider);
    final appBarTitleStyle = Theme.of(context).extension<TextStyleExtension>()!;

    final formKey = ref.watch(formKeyProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.topAppBarTitle,
          style: TextStyle(
            color: appBarTitleStyle.color,
            fontSize: appBarTitleStyle.fontSize,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.navigateTo(FavoriteRoute());
                        // context.router.push(FavoriteRoute()); // これをいいね詳細にならない
                      },
                      child: Text('お気に入り1'),
                    ),
                    search.SearchBar(
                      controller: textEditingController,
                      callback: () async {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(searchApiListPageNotifierProvider.notifier)
                              .search(textEditingController.text);
                        }
                      },
                    ),
                    switch (searchApiListPageState) {
                      Idle() => DeviceCenterWidget(
                          child: NormalText(
                            text: ResponseEnum.notYetSearched.message,
                          ),
                        ),
                      Loading() => Center(child: CircularProgressIndicator()),
                      Data(searchApiModel: final data) => _ApiResults(
                          searchApiModel: data,
                        ),
                      Error(exception: final error) =>
                        Text(createErrorMessage(error, context)),
                    },
                    ElevatedButton(
                      onPressed: () {
                        context.navigateTo(FavoriteRoute());
                        // context.router.push(FavoriteRoute()); // これをいいね詳細にならない
                      },
                      child: Text('お気に入り2'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // context.navigateTo(DashboardRouterRoute());
                        context.navigateTo(DashboardRouterRoute(children: [PostsRoute(id: 3)]));
                        // context.router.push(FavoriteRoute()); // これをいいね詳細にならない
                      },
                      child: Text('tab'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // context.navigateTo(DashboardRouterRoute());
                        context.navigateTo(SwipeRoute());
                        // context.router.push(FavoriteRoute()); // これをいいね詳細にならない
                      },
                      child: Text('try AutoTabsRouter.pageView'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.router.push(UpperDashboardRouterRoute());
                      },
                      child: Text('try AutoTabsRouter.tabBar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ApiResults extends ConsumerWidget {
  const _ApiResults({required this.searchApiModel});
  final SearchApiModel searchApiModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchApiModel.items.isEmpty) {
      return DeviceCenterWidget(
        child: NormalText(
          text: ResponseEnum.zeroData.message,
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: searchApiModel.items.length,
      itemBuilder: (context, index) {
        final item = searchApiModel.items[index];
        final owner = item.owner;
        final avatarUrl = owner.avatarUrl;
        final name = item.name;
        final language = item.language;
        final stargazersCount = item.stargazersCount.toString();
        final watchersCount = item.watchersCount.toString();
        final forksCount = item.forksCount.toString();
        final openIssuesCount = item.openIssuesCount.toString();

        return ResponseDetailCard(
          key: AppKeyName.responseDetailCard(index),
          url: avatarUrl,
          title: name,
          subtitle: language,
          stargazersCount: stargazersCount,
          watchersCount: watchersCount,
          forksCount: forksCount,
          openIssuesCount: openIssuesCount,
          callback: () {
            context.router.push(ApiShowRoute(name: item.name));
            // context.navigateTo(ApiShowRoute(name: item.name));
            // context.router.navigate(ApiShowRouterRoute());
          },
        );
      },
    );
  }
}
