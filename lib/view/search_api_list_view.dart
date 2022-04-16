import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/view/widgets/api_response_card.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class SearchApiListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchApiModelStruct = context
        .select((SearchApiViewModel store) => store.searchApiModelStruct);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubAPI検索App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.8,
                padding: EdgeInsets.only(top: 10),
                child: TextField(
                  onChanged: (text) {
                    context
                        .read<SearchApiViewModel>()
                        .fetchSearchApiModelStruct(text);
                  },
                  decoration: InputDecoration(
                    labelText: 'キーワードを入力して完了ボタンを押してください',
                    errorMaxLines: 2,
                    errorStyle: TextStyle(color: Colors.red),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 7),
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
    );
  }
}