import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
// import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/sheet.dart';

@RoutePage()
class SheetSamplePage extends StatelessWidget {
  const SheetSamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('sample sheet'),
        trailing: Text('aaaa'),),
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
                context.router.push(SheetSampleRoute());
                // Navigator.of(context).push(
                //   CupertinoSheetRoute<void>(
                //     builder: (BuildContext context) => const _SheetScaffold(),
                //   ),
                // );
              },
              child: const Text('Push Another Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
