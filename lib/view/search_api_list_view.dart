import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/response_message.dart';
import 'package:flutter_engineer_codecheck/extention/custom_exception.dart';
import 'package:flutter_engineer_codecheck/view/widgets/api_response_card.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:provider/provider.dart';

class SearchApiListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchApiModelStruct = context
        .select((SearchApiViewModel store) => store.searchApiModelStruct);
    final isEnabled =
        context.select((SearchApiViewModel store) => store.isEnabled);
    var _formController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('GithubAPI検索App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: screenWidth * 0.8,
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _formController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: '入力後、ボタンをタップしてください',
                        errorMaxLines: 2,
                        hintMaxLines: 2,
                        helperMaxLines: 2,
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
                  ElevatedButton(
                      onPressed: () async {
                        if (isEnabled) {
                          try {
                            await context
                                .read<SearchApiViewModel>()
                                .fetchSearchApiModelStruct(
                                    _formController.text);
                            viewSnackBar(
                                context, ResponseMessage.successfulMessage);
                            // エラーレスポンスに関しては手動での再現ができなかったので、APIreferenceのstatus codeを参照
                          } on NotModifiedException catch (_) {
                            viewSnackBar(
                                context, ResponseMessage.notModifiedMessage);
                          } on BadRequestException catch (_) {
                            viewSnackBar(
                                context, ResponseMessage.badRequestMessage);
                          } on ServerProblemException catch (_) {
                            viewSnackBar(
                                context, ResponseMessage.serverProblemMessage);
                          } on TimeoutException catch (e) {
                            viewSnackBar(
                                context, ResponseMessage.timeoutMessage);
                          } on Exception catch (_) {
                            viewSnackBar(
                                context, ResponseMessage.otherExceptionMessage);
                          }
                        } else {
                          return null;
                        }
                      },
                      child: Text('検索')),
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
    );
  }

  void viewSnackBar(BuildContext context, String responseMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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