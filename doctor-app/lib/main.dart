import 'package:flutter/material.dart';
import 'screens/logo.dart';

void main() {
  runApp(const HealthConnectApp());
}

class HealthConnectApp extends StatelessWidget {
  const HealthConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: Logo());
  }
}
