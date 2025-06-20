import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    _textPainter.layout(); // 必須
    size = Size(_textPainter.width, _textPainter.height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    // 背景つけて確認
    final paint = Paint()..color = Colors.yellowAccent;
    canvas.drawRect(offset & size, paint);

    _textPainter.paint(canvas, offset);
  }
}

class MyCustomSingleChildRenderObject extends LeafRenderObjectWidget {
  const MyCustomSingleChildRenderObject({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyCustomRenderObject();
  }
}
