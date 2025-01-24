import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: AutoLeadingButton(),
        title: Text('second page'),
      ),
    );
  }
}