import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/couter2.dart';

class Manager {
  Manager._internal();
  static final instance = Manager._internal();
  int count = 0;
}

// E. StatefulWidgetを継承したクラス
class MyHomePage extends StatefulWidget {
  // コンストラクター
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // 受け取った文字列の入れ物
  final String title;

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

// F. Stateを継承したクラス
class _MyHomePageState extends State<MyHomePage> {
  // G. 状態の保持と更新
  void _incrementCounter() {
    Manager.instance.count++;
    setState(() {
      // _counter++;
    });
  }

  // H. _MyHomePageStateのbuildメソッド
  @override
  Widget build(BuildContext context) {
    // K. ページはScaffoldで組む
    return Scaffold(
      // L. AppBar
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // M. bodyでページの中身をレイアウト
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            // I. _counterの表示
            Text(
              // '$_counter',
              '${Manager.instance.count}',
              // N-2. Theme
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CounterValue2(),
                    ),
                  );
                },
                child: Text('Bページに遷移'))
          ],
        ),
      ),
      // J. ボタン操作に応じて_counterを増やす
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
