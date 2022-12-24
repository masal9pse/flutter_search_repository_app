import 'package:flutter/material.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    required this.controller,
    required this.keyName,
  });

  final TextEditingController controller;
  final String keyName;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        key: Key(keyName),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '文字を入力してください。';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
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
