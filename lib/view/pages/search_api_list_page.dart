import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/indicators/base_circle_progress_indicator.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/texts/normal_text.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/response_detail_card.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/search_bar.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchApiListPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final result = ref.watch(searchApiProvider).result;
    final formController = ref.watch(searchApiProvider).formController;
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
                    controller: formController,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        await ref.read(searchApiProvider.notifier).fetchSearchApiModelStruct(text: formController.text);
                      }
                    },
                  ),
                  FutureBuilder<Result<SearchApiModelStruct, ApiError>>(
                    future: result,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<Result<SearchApiModelStruct, ApiError>>
                          snapshot,
                    ) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return DeviceCenterWidget(
                            widget: NormalText(
                              text: ResponseEnum.notYetSearched.message,
                            ),
                          );
                        case ConnectionState.waiting:
                          return const DeviceCenterWidget(
                            widget: BaseCircleProgressIndicator(),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.data == null) {
                            return DeviceCenterWidget(
                              widget: NormalText(
                                text: ResponseEnum.nullData.message,
                              ),
                            );
                          }

                          final responseWidget = snapshot.data!.when(
                            success: (
                              SearchApiModelStruct searchApiModelStruct,
                            ) {
                              if (searchApiModelStruct.items.isEmpty) {
                                return DeviceCenterWidget(
                                  widget: NormalText(
                                    text: ResponseEnum.zeroData.message,
                                  ),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: searchApiModelStruct.items.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      searchApiModelStruct.items[index];
                                  final owner = item.owner;
                                  final avatarUrl = owner.avatarUrl;
                                  final name = item.name;
                                  final language = item.language ?? '';
                                  final stargazersCount =
                                      item.stargazersCount.toString();
                                  final watchersCount =
                                      item.watchersCount.toString();
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
                            failure: (ApiError apiError) {
                              return DeviceCenterWidget(
                                widget:
                                    NormalText(text: apiError.message ?? ''),
                              );
                            },
                          );
                          return responseWidget;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
