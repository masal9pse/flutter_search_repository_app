import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SliverListExample(),
    );
  }
}

class SliverListExample extends StatelessWidget {
  const SliverListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 80,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver List Example'),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('$index')),
                  title: Text('Item $index'),
                );
              },
              childCount: 20, // 表示するリストの数
            ),
          ),
        ],
      ),
    );
  }
}