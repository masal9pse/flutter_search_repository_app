// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/sheet.dart';

/// Flutter code sample for [CupertinoSheetRoute].
void main() {
  runApp(const CupertinoSheetApp());
}

class CupertinoSheetApp extends StatelessWidget {
  const CupertinoSheetApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return const CupertinoApp(title: 'Cupertino Sheet', home: HomePage());
    return MaterialApp(title: 'Cupertino Sheet', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      // child: Center(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CupertinoButton.filled(
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoSheetRoute<void>(
                    builder: (BuildContext context) => const _SheetScaffold(),
                  ),
                );
              },
              child: const Text('Open Bottom Sheet'),
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
    // return CupertinoPageScaffold(
    return Scaffold(
      // child: Center(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('CupertinoSheetRoute'),
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).maybePop();
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoSheetRoute<void>(
                    builder: (BuildContext context) => const _SheetScaffold(),
                  ),
                );
              },
              child: const Text('Open Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
