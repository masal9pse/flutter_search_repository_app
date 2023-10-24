import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/buttons/search_elevated_button.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/forms/search_form.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.controller,
    required this.callback,
  });

  final TextEditingController controller;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: SearchForm(
            controller: controller,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: SearchElevatedButton(
            callback: callback,
          ),
        ),
      ],
    );
  }
}
