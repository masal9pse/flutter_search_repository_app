import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScrollableListPage(),
    );
  }
}

class ScrollableListPage extends StatelessWidget {
  const ScrollableListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();
    final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ScrollablePositionedList'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              itemScrollController.scrollTo(
                index: 50,
                duration: const Duration(seconds: 1),
              );
            },
            child: const Text('Scroll to item 50'),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              itemCount: 100,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
            ),
          ),
        ],
      ),
    );
  }
}
