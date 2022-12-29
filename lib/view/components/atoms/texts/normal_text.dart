import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  const NormalText({super.key, required this.text, this.size = 16});

  final String text;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
      ),
    );
  }
}
