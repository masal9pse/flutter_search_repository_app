import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application/state/text_editing_controller_provider.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/texts/normal_text.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/response_detail_card.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/search_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchApiListPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchApiResults = ref.watch(searchApiNotifierProvider);
    final textEditingController = ref.watch(textEditingControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(PageInfoEnum.top.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: screenWidth * 0.8,
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  SearchBar(
                    controller: textEditingController,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(searchApiNotifierProvider.notifier)
                            .updateState(textEditingController.text);
                      }
                    },
                  ),
                  searchApiResults.when(
                    data: (value) {
                      if (value == null) {
                        return const DeviceCenterWidget(
                            widget: NormalText(text: 'フォームに値を入力してください'));
                      }
                      if (value.items.isEmpty) {
                        return NormalText(text: ResponseEnum.zeroData.message);
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.items.length,
                          itemBuilder: (context, index) {
                            final item = value.items[index];
                            final owner = item.owner;
                            final avatarUrl = owner.avatarUrl;
                            final name = item.name;
                            final language = item.language ?? '';
                            final stargazersCount =
                                item.stargazersCount.toString();
                            final watchersCount = item.watchersCount.toString();
                            final forksCount = item.forksCount.toString();
                            final openIssuesCount =
                                item.openIssuesCount.toString();
                      
                            return ResponseDetailCard(
                              url: avatarUrl,
                              title: name,
                              subtitle: language,
                              stargazersCount: stargazersCount,
                              watchersCount: watchersCount,
                              forksCount: forksCount,
                              openIssuesCount: openIssuesCount,
                              callback: () {
                                context.push(
                                  PageInfoEnum.show.route,
                                  extra: item,
                                );
                              },
                            );
                          },
                        );                      
                    },
                    error: (error, stack) => const Text('インターネットに接続できませんでした'),
                    loading: () => const DeviceCenterWidget(
                      widget: CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
