# 使用例

## メインファイル

lib/presentations/screen/apple/screen.dart

```dart

import 'package:flutter/material.dart';

// このファイルで使用するものをpartでインポート
part 'part/_extension.dart';
part 'part/_my_button.dart';
part 'part/_my_list_tile.dart';

class AppleScreen extends StatelessWidget {
  const AppleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
        actions: [
          ElevatedButton(
            onPressed: () => _showExtensionSnackBar(context),
            child: const Text('Button'),
          ),
        ],
      ),
      body: ListView(
        children: [
          const _MyListTile(
            title: 'posts',
            subtitle: 'subtitle',
          ),
          _MyButton(
            onPressed: () => _showExtensionSnackBar(context),
          ),
        ],
      ),
    );
  }
}

```

## プライベートなウィジェットとして切り出したファイル(VRTを書かないケース)

lib/presentations/screen/apple/part/_my_button.dart

```dart

// メインとなるファイルを紐付ける
part of '../screen.dart';

class _MyButton extends StatelessWidget {
  const _MyButton({
    required this.onPressed,
  });
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Button'),
    );
  }
}

```

## プライベートなウィジェットとして切り出したファイル(VRTを書くケース)

lib/presentations/screen/apple/part/_my_button.dart

```dart

// メインとなるファイルを紐付ける
part of '../screen.dart';

@visibleForTesting
class MyButton extends StatelessWidget {
  const _MyButton({
    required this.onPressed,
  });
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Button'),
    );
  }
}

```
