import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/texts/large_text.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/atoms/texts/normal_text.dart';

class ResponseText extends StatelessWidget {
  const ResponseText({
    super.key,
    required this.title,
    required this.titleValue,
  });

  final String title;
  final String titleValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LargeText(title: title),
        NormalText(
          text: titleValue,
        ),
      ],
    );
  }
}
