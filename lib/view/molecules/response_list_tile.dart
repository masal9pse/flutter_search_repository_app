import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/view/atoms/base_image_network.dart';

class ResponseListTile extends StatelessWidget {
  const ResponseListTile({
    super.key,
    required this.url,
    required this.title,
    required this.subtitle,
  });

  final String url;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: BaseImageNetWork.build(url: url),
      title: Text(title),
      subtitle: Text(subtitle ?? ''),
    );
  }
}
