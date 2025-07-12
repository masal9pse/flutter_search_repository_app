import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/my_home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyHomePage Golden Tests', () {
    goldenTest(
      'renders correctly',
      fileName: 'my_home_page',
      builder: () => GoldenTestScenario(
          name: 'HomePage',
          constraints: BoxConstraints.tight(Size(320, 568)),
          child: MyHomePage()),
    );
  });
}
