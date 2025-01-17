import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Sheet Example'),
          automaticBackgroundVisibility: false,
        ),
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
              CupertinoButton.filled(
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
