import 'package:flutter/material.dart';

class CenterContainer {
  static Container build({Widget? widget, double? height}) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: widget,
    );
  }
}
