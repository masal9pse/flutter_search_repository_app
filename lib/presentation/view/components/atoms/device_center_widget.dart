import 'package:flutter/material.dart';

/// 高さが明確に指定できないWidget内(SingleChildScrollView等)で画面の真ん中に配置するWidget
class DeviceCenterWidget extends StatelessWidget {
  const DeviceCenterWidget({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(child: child),
    );
  }
}
