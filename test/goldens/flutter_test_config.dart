import 'dart:async';

import 'package:alchemist/alchemist.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async =>
    AlchemistConfig.runWithConfig(
      config: const AlchemistConfig(
        ciGoldensConfig: CiGoldensConfig(
          // obscureText: false,
          // renderShadows: true,
          enabled: false,
          // theme: ThemeData(fontFamily: 'NotoSansJP'),
        ),
        platformGoldensConfig: PlatformGoldensConfig(),
      ),
      run: testMain,
    );
