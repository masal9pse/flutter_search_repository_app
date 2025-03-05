import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PupUpMenu bug',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PupUpMenu bug'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _itemCount = 4;
  final _checkedItems = [false, false, false, false];

  int? _selectedIndex;
  bool _applyWorkaround = false;

  @override
  Widget build(BuildContext context) {
    final _checkedItemWidgets = List.generate(_itemCount, (index) {
      return CheckedPopupMenuItem(
        child: Text("Check $index"),
        checked: _checkedItems[index],
        value: index,
      );
    });

    final _itemWidgets = List.generate(_itemCount, (index) {
      return PopupMenuItem(
        child: Text("Check $index"),
        value: index,
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.check),
            offset: Offset(0, 100),
            onSelected: (index) {
              setState(() {
                _checkedItems[index] = !_checkedItems[index];
              });
            },
            itemBuilder: (_) => _checkedItemWidgets,
          ),
          PopupMenuButton(
            initialValue:
                _selectedIndex, // Setting this makes the offset focus on this item
            icon: Icon(Icons.close),
            offset: Offset(
                0,
                100 +
                    (_applyWorkaround ? 44 * (_selectedIndex ?? 0) : 0)
                        .toDouble()),
            onSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            itemBuilder: (_) => _itemWidgets,
          )
        ],
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
                value: _applyWorkaround,
                onChanged: (checked) {
                  if (checked != null) {
                    setState(() {
                      _applyWorkaround = checked;
                    });
                  }
                }),
            SizedBox(width: 8.0),
            Text("Apply workaround"),
          ],
        ),
      ),
    );
  }
}