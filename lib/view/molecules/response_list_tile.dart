import 'package:flutter/material.dart';

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
      leading: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, object, _) {
          return const Icon(
            Icons.error,
            color: Colors.red,
          );
        },
      ),
      title: Text(title),
      subtitle: Text(subtitle ?? ''),
    );
  }
}
