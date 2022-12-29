import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/atoms/buttons/search_elevatate_button.dart';
import 'package:flutter_engineer_codecheck/view/atoms/search_form.dart';

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
        Container(
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
