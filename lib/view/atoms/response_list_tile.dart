import 'package:flutter/material.dart';

class ResponseListTile extends StatelessWidget {
  const ResponseListTile({
    super.key,
    required this.url,
    required this.title,
    required this.subtitle,
    this.callback,
  });

  final String url;
  final String title;
  final String? subtitle;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        url,
        errorBuilder: (context, object, _) {
          return const Icon(
            Icons.error,
            color: Colors.red,
          );
        },
      ),
      title: Text(title),
      subtitle: Text(subtitle ?? ''),
      onTap: () {
        if (callback == null) {
          return;
        }
        callback!();
      },
    );
  }
}
