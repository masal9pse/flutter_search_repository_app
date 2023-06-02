import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/counter.dart';

class CounterValue2 extends StatefulWidget {
  const CounterValue2({super.key});

  @override
  State<CounterValue2> createState() => _CounterValue2State();
}

class _CounterValue2State extends State<CounterValue2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('aaaaa'),),
      body: Center(
        child: Text('${Manager.instance.count}'),
      ),
    );
  }
}
