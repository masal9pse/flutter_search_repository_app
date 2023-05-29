import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/const/enum/response_enum.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/indicators/base_circle_progress_indicator.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/view/components/atoms/texts/normal_text.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/response_detail_card.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/search_bar.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SearchApiHomeListPage extends StatelessWidget {
  const SearchApiHomeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) =>
              SearchApiRepositoryImpl(searchApiClient: SearchApiClient()),
        ),
        // 自動破棄されていないかもしれないので、disposeを呼ぶ必要があるかも
        ChangeNotifierProvider(
          create: (_) => TextEditingController(),
          child: SearchApiListPage(),
        ),
        StateNotifierProvider<SearchApiViewModel, SearchApiModelStruct>(
          create: (context) => SearchApiViewModel(
            read: context.read,
            // searchApiRepository: context.read<SearchApiRepositoryImpl>(),
          ),
          child: SearchApiListPage(),
        ),
      ],
      child: SearchApiListPage(),
    );
  }
}

class SearchApiListPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final items = context
        .select<SearchApiModelStruct, List<Item>>((store) => store.items);
    final textEditingController = context.watch<TextEditingController>();
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
                child: Column(children: [
                  SearchBar(
                    controller: textEditingController,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        await context
                            .read<SearchApiViewModel>()
                            .fetchSearchApiModelStruct(
                              text: textEditingController.text,
                            );
                      }
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    // itemCount: state.items.length,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      // final item = state[index];
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
                          context.push(
                            PageInfoEnum.show.route,
                            extra: item,
                          );
                        },
                      );
                    },
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}
