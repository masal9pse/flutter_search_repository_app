import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> animalList = ['dog', 'cat', 'elephant', 'rabbit'];
  List<String> displayList = [];
  int lastIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    displayList.add(animalList[lastIndex]);
    lastIndex++;
  }

  Future<void> _loadMore() async {
    if (isLoading || lastIndex >= animalList.length) return;
    setState(() => isLoading = true);

    // Simulate a delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      displayList.add(animalList[lastIndex]);
      lastIndex++;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              scrollNotification.metrics.extentAfter == 0) {
            _loadMore();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: displayList.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < displayList.length) {
              return ListTile(title: Text(displayList[index]));
            } else {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
