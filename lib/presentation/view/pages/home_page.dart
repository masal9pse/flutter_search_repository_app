import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/router/router.gr.dart';
import 'package:flutter_engineer_codecheck/presentation/view/components/organisms/sheet.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class EmptyRouterPage extends 
@RoutePage()
class HomeRouterPage extends AutoRouter {
  const HomeRouterPage({super.key});
}

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('abc'),
       ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       CupertinoSheetRoute<void>(
              //         builder: (BuildContext context) => const _SheetScaffold(),
              //       ),
              //     );
              //   },
              //   child: Text('test bottom sheet'),
              // ),
              CupertinoButton.filled(
                onPressed: () {
                  context.router.push(SheetSampleRoute());
                  // Navigator.of(context).push(
                  //   CupertinoSheetRoute<void>(
                  //     builder: (BuildContext context) => const _SheetScaffold(),
                  //   ),
                  // );
                },
                child: const Text('Open Bottom Sheet'),
              ),
            ],
          ),
        ),
      );
  }
}

// class _SheetScaffold extends StatelessWidget {
//   const _SheetScaffold();

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('CupertinoSheetRoute'),
//             CupertinoButton.filled(
//               onPressed: () {
//                 Navigator.of(context).maybePop();
//               },
//               child: const Text('Go Back'),
//             ),
//             const Text('You can also close this sheet by dragging downwards'),
//             CupertinoButton.filled(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   CupertinoSheetRoute<void>(
//                     builder: (BuildContext context) => const _SheetScaffold(),
//                   ),
//                 );
//               },
//               child: const Text('Push Another Sheet'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
