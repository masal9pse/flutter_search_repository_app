import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/pigeon_test.g.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BatteryApi _batteryApi = BatteryApi();
  int? _batteryLevel;

  @override
  void initState() {
    super.initState();
    _fetchBatteryLevel();
  }

  Future<void> _fetchBatteryLevel() async {
    try {
      final batteryInfo = await _batteryApi.getBatteryLevel();
      setState(() {
        _batteryLevel = batteryInfo.level;
      });
    } catch (e) {
      print("Failed to get battery level: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Battery Level")),
        body: Center(
          child: Text(
            _batteryLevel != null ? "Battery Level: $_batteryLevel%" : "Fetching...",
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
