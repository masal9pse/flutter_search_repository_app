import 'package:flutter/material.dart';

class BaseImageNetWork {
  static Image build({required String url}) {
    return Image.network(
      url,
      errorBuilder: (context, object, _) {
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
      },
    );
  }
}
