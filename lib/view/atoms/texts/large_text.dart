import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  const LargeText({super.key, required this.title, this.size = 20});

  final String title;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
      ),
    );
  }
}
