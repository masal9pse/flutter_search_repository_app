import 'package:flutter/material.dart';
import 'pigeon_test.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<BatteryInfo> getBatteryLevel() async {
    final batteryApi = BatteryApi();
    return await batteryApi.getBatteryLevel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Battery Level')),
        body: Center(
          child: FutureBuilder(
            future: getBatteryLevel(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text('Battery Level: ${snapshot.data!.level.toString()}%');
            },
          ),
        ),
      ),
    );
  }
}
