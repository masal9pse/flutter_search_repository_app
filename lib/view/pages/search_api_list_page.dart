import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/view/atoms/indicators/base_circle_progress_indicator.dart';
import 'package:flutter_engineer_codecheck/view/atoms/device_center_widget.dart';
import 'package:flutter_engineer_codecheck/view/organisms/search_bar.dart';
import 'package:flutter_engineer_codecheck/view/organisms/response_list_view.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class SearchApiListPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final result = context.select((SearchApiViewModel store) => store.result);
    final deviceHeight = MediaQuery.of(context).size.height;
    final formController =
        context.select((SearchApiViewModel store) => store.formController);
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
                  Consumer<SearchApiViewModel>(
                    builder: (context, model, child) {
                      return SearchBar(
                        controller: formController,
                        callback: () async {
                          if (_formKey.currentState!.validate()) {
                            await context
                                .read<SearchApiViewModel>()
                                .fetchSearchApiModelStruct(
                                  formController.text,
                                );
                          }
                        },
                      );
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
                          return const DeviceCenterWidget(
                            widget: Text('検索したいキーワードを入力してください。'),
                          );
                        case ConnectionState.waiting:
                          return const DeviceCenterWidget(
                            widget: BaseCircleProgressIndicator(),
                          );
                        case ConnectionState.active:
                        case ConnectionState.done:
                          if (snapshot.data == null) {
                            return const DeviceCenterWidget(
                              widget: Text('検索データを取得できませんでした。'),
                            );
                          }

                          final responseWidget = snapshot.data!.when(
                            success: (
                              SearchApiModelStruct searchApiModelStructs,
                            ) {
                              return ResponseListView(
                                searchApiModelStruct: searchApiModelStructs,
                              );
                            },
                            failure: (ApiError apiError) {
                              return DeviceCenterWidget(
                                widget: Text(apiError.message ?? ''),
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
