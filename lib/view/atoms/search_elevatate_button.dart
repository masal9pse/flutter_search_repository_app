import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_key_name.dart';

class SearchElevatedButton extends StatelessWidget {
  const SearchElevatedButton({
    super.key,
    required this.callback,
  });

  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: AppKeyName.searchElevatedButton,
      onPressed: callback,
      child: const Text('検索'),
    );
  }
}
