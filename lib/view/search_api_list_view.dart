import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';

class SearchApiListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubAPI検索App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: screenWidth * 0.8,
            padding: EdgeInsets.only(top: 10),
            child: TextField(
              onChanged: (text) {
                // あとでview_modelから呼び出す。
                SearchApiService().getApiListInfo();
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
        ),
      ),
    );
  }
}