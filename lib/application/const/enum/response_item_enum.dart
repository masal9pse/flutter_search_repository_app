import 'package:flutter/material.dart';

enum ResponseItemEnum {
  // リポジトリと言語名に関しては現状使用していないので、仮のアイコンをひとまず定義
  name(title: 'リポジトリ名',icon: Icons.browser_not_supported_outlined),
  language(title: '言語名',icon: Icons.browser_not_supported_outlined),
  stargazersCount(title: 'スター数', icon: Icons.star),
  watchersCount(title: 'watcher数', icon: Icons.remove_red_eye),
  forksCount(title: 'fork数', icon: Icons.food_bank_sharp),
  openIssuesCount(title: 'issue数', icon: Icons.report);

  const ResponseItemEnum({required this.title, required this.icon});
  final String title;
  final IconData icon;
}
