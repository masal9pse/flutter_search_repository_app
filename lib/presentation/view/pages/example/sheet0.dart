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
    return const CupertinoApp(title: 'Cupertino Sheet', home: HomePage());
    // return const MaterialApp(title: 'Cupertino Sheet', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoSheetRoute<void>(
                      builder: (BuildContext context) => const _SheetScaffold(),
                    ),
                  );
                },
                child: Text('test bottom sheet'),
              ),
              // CupertinoButton.filled(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       CupertinoSheetRoute<void>(
              //         builder: (BuildContext context) => const _SheetScaffold(),
              //         // builder: (BuildContext context) => const SheetSamplePage(),
              //         // builder: (BuildContext context) => const SheetSampleRoute(),
              //       ),
              //     );
              //     // context.router.push(SheetSampleRoute());
              //   },
              //   child: const Text('Open Bottom Sheet'),
              // ),
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
    return CupertinoPageScaffold(
      child: Center(
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
