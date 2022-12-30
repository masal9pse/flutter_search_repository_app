import 'package:flutter/material.dart';

class ResponseListTile extends StatelessWidget {
  const ResponseListTile({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final Image image;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: image,
      title: Text(title),
      subtitle: Text(subtitle ?? ''),
    );
  }
}
