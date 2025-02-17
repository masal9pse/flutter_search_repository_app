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
    return Scaffold(
      appBar: AppBar(title: Text('aaaaaa'),),
      body: Column(
        children: [
          AnimatedAlign(
            alignment: selected.value ? Alignment.center : Alignment.topLeft,
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
        ],
      ),
    );
  }
}
