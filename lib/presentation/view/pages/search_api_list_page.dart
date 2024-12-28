import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application_services/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/application_services/di/use_cases.dart';
import 'package:flutter_engineer_codecheck/application_services/state/form_key_provider.dart';
import 'package:flutter_engineer_codecheck/application_services/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application_services/state/text_editing_controller_provider.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/application_services/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/texts/normal_text.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/response_detail_card.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/search_bar.dart'
    as search;
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// トップページ
class SearchApiListPage extends ConsumerWidget {

  const SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchApiResults = ref.watch(searchApiNotifierProvider);
    final textEditingController = ref.watch(textEditingControllerProvider);
    final formKey = ref.watch(formKeyProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
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
                    search.SearchBar(
                      controller: textEditingController,
                      callback: () async {
                        if (formKey.currentState!.validate()) {
                          final useCase = ref.read(searchGitHubDataUseCaseProvider);
                          await useCase
                              .searchGitHubData(textEditingController.text);
                        }
                      },
                    ),
                    searchApiResults.when(
                      data: (value) {
                        if (value == null) {
                          return DeviceCenterWidget(
                            child: NormalText(
                              text: ResponseEnum.notYetSearched.message,
                            ),
                          );
                        }
                        if (value.items.isEmpty) {
                          return DeviceCenterWidget(
                            child: NormalText(
                              text: ResponseEnum.zeroData.message,
                            ),
                          );
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
                            final language = item.language;
                            final stargazersCount =
                                item.stargazersCount.toString();
                            final watchersCount = item.watchersCount.toString();
                            final forksCount = item.forksCount.toString();
                            final openIssuesCount =
                                item.openIssuesCount.toString();

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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ApiShowPage(
                                      id: index,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      error: (error, stack) {
                        return DeviceCenterWidget(
                          child: Text(ResponseEnum.noConnection.message),
                        );
                      },
                      loading: () => const DeviceCenterWidget(
                        child: CircularProgressIndicator(),
                      ),
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
