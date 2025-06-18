import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: Center(
        child: MyCustomSingleChildRenderObject(),
      ),
    ),
  ));
}

class MyCustomRenderObject extends RenderBox {
  final TextPainter _textPainter = TextPainter(
    text: const TextSpan(
      text: 'Hello, RenderObject!',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    ),
    textDirection: TextDirection.ltr,
  );

  @override
  void performLayout() {
    _textPainter.layout(); // テキストサイズを計算
    size = Size(_textPainter.width, _textPainter.height); // 自身のサイズをテキストに合わせる
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset); // テキストを描画
  }
}

class MyCustomSingleChildRenderObject extends LeafRenderObjectWidget {
  const MyCustomSingleChildRenderObject({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyCustomRenderObject();
  }
}
