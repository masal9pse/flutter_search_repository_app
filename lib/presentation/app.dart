import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart';


class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: SliverListExample(),
      home: SearchApiListPage(),
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