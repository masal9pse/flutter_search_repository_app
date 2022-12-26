import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        key: AppKeyName.topPageSearchTextField,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '文字を入力してください。';
          }
          return null;
        },
        controller: controller,
        decoration: const InputDecoration(
          errorStyle: TextStyle(color: Colors.red),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 7),
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
    );
  }
}
