import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/config/app_error_message.dart';
import 'package:flutter_engineer_codecheck/application_services/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/application_services/state/form_key_provider.dart';
import 'package:flutter_engineer_codecheck/application_services/state/search_api_list_page_notifier.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/domain/model/app_state.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/presentation/theme_extention.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/texts/normal_text.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/response_detail_card.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/search_bar.dart'
    as search;
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// トップページ
@RoutePage()
class SearchApiListPage extends HookConsumerWidget {
  const SearchApiListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditingController = useTextEditingController();
    final searchApiListPageState = ref.watch(searchApiListPageNotifierProvider);
    final formKey = ref.watch(formKeyProvider);
    final scrollController = useScrollController();

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            print(notification.metrics);
            if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent) {
              ref
                  .read(searchApiListPageNotifierProvider.notifier)
                  .loadMore('react');
            }
            return true;
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ),
              SliverToBoxAdapter(
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: search.SearchBar(
                        controller: textEditingController,
                        callback: () async {
                          if (formKey.currentState!.validate()) {
                            ref
                                .read(
                                    searchApiListPageNotifierProvider.notifier)
                                .search(textEditingController.text);
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              switch (searchApiListPageState) {
                Idle() => SliverToBoxAdapter(
                    child: DeviceCenterWidget(
                      child: NormalText(
                        text: ResponseEnum.notYetSearched.message,
                      ),
                    ),
                  ),
                Loading() => const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                Data(searchApiModel: final data) ||
                AddLoading(searchApiModel: final data) =>
                  _ApiResults(searchApiModel: data),
                Error(exception: final error) => SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('error'),
                    ),
                  ),
              },
              if (searchApiListPageState is AddLoading) ...[
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // スクロール処理は後で追加予定
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
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
      return SliverToBoxAdapter(
        child: DeviceCenterWidget(
          child: NormalText(
            text: ResponseEnum.zeroData.message,
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) {
              //       return const ApiShowPage();
              //     },
              //   ),
              // );
            },
          );
        },
        childCount: searchApiModel.items.length,
      ),
    );
  }
}
