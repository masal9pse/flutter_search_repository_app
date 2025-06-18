import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class ScrollableListPage extends HookWidget {
  const ScrollableListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final itemScrollController = useMemoized(ItemScrollController.new);
    final itemPositionsListener = useMemoized(ItemPositionsListener.create);
    final firstVisibleItem = useState(0);

    useEffect(() {
      void listener() {
        final positions = itemPositionsListener.itemPositions.value;
        if (positions.isNotEmpty) {
          final firstIndex = positions
              .where((position) => position.itemLeadingEdge <= 0.0)
              .map((e) => e.index)
              .fold<int>(999999, (prev, curr) => curr < prev ? curr : prev);
          firstVisibleItem.value = firstIndex;
        }
      }

      itemPositionsListener.itemPositions.addListener(listener);
      return () => itemPositionsListener.itemPositions.removeListener(listener);
    }, [itemPositionsListener]);

    return Scaffold(
      appBar: AppBar(
        title: Text('先頭: Item ${firstVisibleItem.value}'),
      ),
      body: ScrollablePositionedList.builder(
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
        ),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      ),
    );
  }
}
