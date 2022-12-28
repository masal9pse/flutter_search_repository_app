import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/const/app_size_list.dart';

class LargeText extends StatelessWidget {
  const LargeText({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppSizeList.largeSize,
      ),
    );
  }
}
