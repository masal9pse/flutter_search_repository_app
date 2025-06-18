import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyCustomSingleChildRenderObject());
}

class MyCustomRenderObject extends RenderBox {
  
}

class MyCustomSingleChildRenderObject extends SingleChildRenderObjectWidget {
  const MyCustomSingleChildRenderObject({super.key});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MyCustomRenderObject();
  }
}

