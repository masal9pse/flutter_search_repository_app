import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/molecules/search_bar.dart';
import 'package:flutter_engineer_codecheck/view/organisms/api_response_card.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class SearchApiListPage extends StatelessWidget {
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
                  SearchBar(
                    controller: formController,
                    callback: () {
                      context
                          .read<SearchApiViewModel>()
                          .fetchSearchApiModelStruct(
                            formController.text,
                          );
                    },
                  ),
                  searchApiModelStruct != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchApiModelStruct.items.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: ApiResponseCard(
                                item: searchApiModelStruct.items[index],
                              ),
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
