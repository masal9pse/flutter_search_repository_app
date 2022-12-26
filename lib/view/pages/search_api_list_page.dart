import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';
import 'package:flutter_engineer_codecheck/const/response_message.dart';
import 'package:flutter_engineer_codecheck/view/molecules/search_bar.dart';
import 'package:flutter_engineer_codecheck/view/organisms/response_list_view.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class SearchApiListPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchApiModelStruct = context
        .select((SearchApiViewModel store) => store.searchApiModelStruct);
    final formController =
        context.select((SearchApiViewModel store) => store.formController);
    // この変数を使うと異常系のテストが通らないため意図的に残す。
    // final apiError =
    //     context.select((SearchApiViewModel store) => store.apiError);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubAPI検索App'),
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
                            // context.selectでapiErrorを定義した場合に異常系のテストが通りません。、
                            // fetchSearchApiModelStructでは、apiErrorを更新していることが確認できたのですが、
                            // なぜかこのページに戻ってきた際のapiErrorを確認するとnullの状態になっており、SUCCESSFULMESSAGEが表示されました。
                            // formControllerやsearchApiModelStructは意図通りに取得できたのですが....
                            // Consumerにしたところ、apiErrorがこのページでも取得できており、テストが通りました。
                            // なぜConsumerから値を引っ張るとテストが通るのか現状わかっておりません。
                            if (model.apiError != null) {
                              viewSnackBar(
                                context,
                                model.apiError!.message ?? '',
                              );
                            } else {
                              viewSnackBar(context, SUCCESSFULMESSAGE);
                            }
                          }
                        },
                      );
                    },
                  ),
                  searchApiModelStruct != null
                      ? ResponseListView(
                          searchApiModelStruct: searchApiModelStruct,
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void viewSnackBar(BuildContext context, String responseMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: AppKeyName.snackBar,
        content: Text(responseMessage),
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
