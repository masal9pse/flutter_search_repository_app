import 'package:flutter/material.dart';

class IconCount extends StatelessWidget {
  const IconCount({
    super.key,
    required this.icon,
    required this.count,
  });

  final IconData icon;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Text(count),
      ],
    );
  }
}
