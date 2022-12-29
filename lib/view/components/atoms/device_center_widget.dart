import 'package:flutter/material.dart';

class DeviceCenterWidget extends StatelessWidget {
  const DeviceCenterWidget({super.key, this.widget});

  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      alignment: Alignment.center,
      child: widget,
    );
  }
}
