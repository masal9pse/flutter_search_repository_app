import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';

class SearchElevatedButton extends StatelessWidget {
  const SearchElevatedButton({
    super.key,
    this.text = '検索',
    required this.callback,
  });

  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: AppKeyName.searchElevatedButton,
      onPressed: callback,
      child: Text(text),
    );
  }
}
