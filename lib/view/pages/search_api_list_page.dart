import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/enum/page_info_enum.dart';
import 'package:flutter_engineer_codecheck/view/components/organisms/search_bar.dart';
import 'package:flutter_engineer_codecheck/view_model/search_api_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchApiListPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SearchApiListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = ref.watch(searchApiProvider('ruby'));
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
                    controller: TextEditingController(),
                    callback: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   await ref.read(searchApiProvider.notifier).fetchSearchApiModelStruct(text: formController.text);
                      // }
                    },
                  ),
                  provider.when(
                    data: (value) {
                      return Text(value!.items.first.name);
                    },
                    error: (error, stack) => Text('Error: $error'),
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
