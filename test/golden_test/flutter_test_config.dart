import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return AlchemistConfig.runWithConfig(
    config: AlchemistConfig(
      ciGoldensConfig: CiGoldensConfig(
        // obscureText: false,
        // renderShadows: true,
        enabled: false,
        // theme: ThemeData(fontFamily: 'NotoSansJP'),
      ),
      platformGoldensConfig: const PlatformGoldensConfig(
        // enabled: false,        
      ),
    ),
    run: testMain,
  );
}