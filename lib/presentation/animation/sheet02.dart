import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MaterialApp(home: MyWidget()));
}

class MyWidget extends HookWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = useState(false);
    final now = useState(0.0);
    return Scaffold(
      appBar: AppBar(title: Text('aaaaaa'),),
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: now.value, // 0が完全に透明で、1が完全な不透明
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 3000),
            child: AnimatedAlign(
              alignment: selected.value ? Alignment.center : Alignment.topLeft,
              curve: Curves.bounceOut.flipped,
              // alignment: selected.value ? Alignment(0.1, 0.1) : Alignment(0.5,0.5),
              // alignment: selected.value ? Alignment(0.1, 0.1) : Alignment(0.5,0.5),
              duration: Duration(milliseconds: 300),
              child: ElevatedButton(
                child: Text('aaaa'),
                onPressed: () {
                  selected.value = !selected.value;
                },
              ),
            ),
          ),
          ElevatedButton(onPressed: () {
            now.value = 1.0;
          }, child: Text('view'))
        ],
      ),
    );
  }
}
