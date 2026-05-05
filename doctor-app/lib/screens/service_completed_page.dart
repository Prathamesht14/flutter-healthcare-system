import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

class ServiceCompletedPage extends StatefulWidget {
  const ServiceCompletedPage({super.key});

  @override
  State<ServiceCompletedPage> createState() => _ServiceCompletedPageState();
}

class _ServiceCompletedPageState extends State<ServiceCompletedPage> {
  @override
  void initState() {
    super.initState();

    // ⏱️ Redirect after 6 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔵 Header
          Container(
            height: 90,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF3FA9F5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            alignment: Alignment.center,
            child: const Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                'Service Completed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(height: 80),

          const Icon(
            Icons.check_circle,
            size: 80,
            color: Colors.green,
          ),

          const SizedBox(height: 20),

          const Text(
            'Service Completed!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
