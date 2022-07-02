import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/response_message.dart';
import 'package:flutter_engineer_codecheck/view/widgets/api_response_card.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class SearchApiListView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchApiModelStruct = context
        .select((SearchApiViewModel store) => store.searchApiModelStruct);
    final formController =
        context.select((SearchApiViewModel store) => store.formController);
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
              padding: EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        child: TextFormField(
                          key: Key('search_text_field'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '文字を入力してください。';
                            }
                            return null;
                          },
                          controller: formController,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.red),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 7),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Consumer<SearchApiViewModel>(
                          builder: (context, model, child) {
                        return Container(
                          width: screenWidth * 0.2,
                          child: ElevatedButton(
                              key: Key('search_elevated_button'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await context
                                      .read<SearchApiViewModel>()
                                      .fetchSearchApiModelStruct(
                                        formController.text,
                                      );

                                  if (model.apiError != null) {
                                    viewSnackBar(
                                        context, model.apiError?.message ?? '');
                                  } else {
                                    viewSnackBar(context, SUCCESSFULMESSAGE);
                                  }
                                }
                              },
                              child: Text('検索')),
                        );
                      }),
                    ],
                  ),
                  searchApiModelStruct != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchApiModelStruct.items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ApiResponseCard(
                                  item: searchApiModelStruct.items[index]),
                            );
                          })
                      : Container()
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
        key: Key('snack_bar'),
        content: Text(responseMessage),
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
  }
}
