// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/app.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/sheet.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/sheet_sample_page.dart';

/// Flutter code sample for [CupertinoSheetRoute].

void main() {
  runApp(const CupertinoSheetApp());
}

class CupertinoSheetApp extends StatelessWidget {
  const CupertinoSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const CupertinoApp(title: 'Cupertino Sheet', home: HomePage());
    return const MaterialApp(title: 'Cupertino Sheet', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('test sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   CupertinoSheetRoute<void>(
                //     builder: (BuildContext context) => const _SheetScaffold(),
                //   ),
                // );

                // Navigator.of(context)
                //     .push(CupertinoPageRoute(builder: (_) => _SheetScaffold()));
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => _SheetScaffold()));

                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      // 表示する画面のWidget
                      return _SheetScaffold();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      // 遷移時のアニメーションを指定
                      final Offset begin = Offset(0.0, 1.0);
                      // final Offset begin = Offset(0.0, 0.8);
                      // どこまで遷移するかを決めることができる。
                      // final Offset end = Offset.zero;
                      final Offset end = Offset(0.0,0.5);
                      final Tween<Offset> tween = Tween(begin: begin, end: end);
                      final Animation<Offset> offsetAnimation =
                          animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Text('test bottom sheet233'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetScaffold extends StatelessWidget {
  const _SheetScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('CupertinoSheetRoute'),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.of(context).maybePop();
              },
              child: const Text('Go Back'),
            ),
            const Text('You can also close this sheet by dragging downwards'),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoSheetRoute<void>(
                    builder: (BuildContext context) => const _SheetScaffold(),
                  ),
                );
              },
              child: const Text('Push Another Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
