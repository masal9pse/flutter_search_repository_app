import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/application/state/search_api_notifier.dart';
import 'package:flutter_engineer_codecheck/application/state/text_editing_controller_provider.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/search_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchApiListPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchApiResults = ref.watch(searchApiNotifierProvider);
    final textEditingController = ref.watch(textEditingControllerProvider);
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
                    controller: textEditingController,
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(searchApiNotifierProvider.notifier)
                            .updateState(textEditingController.text);
                      }
                    },
                  ),
                  searchApiResults.when(
                    data: (value) {
                      if (value == null) {
                        return const Text('No data');
                      }
                      if (value.totalCount == 0) {
                        return const Text('0データ');
                      }
                      return Text(value.items.first.name);
                    },
                    error: (error, stack) => const Text('インターネットに接続できませんでした'),
                    loading: () => const CircularProgressIndicator(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
