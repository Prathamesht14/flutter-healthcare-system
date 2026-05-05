import 'package:flutter/material.dart';
import 'sign_up.dart'; // <-- your signup page

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // same white as image
      body: SafeArea(
        child: Column(
          children: [
            // Top blue wave
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF5AA9FF), Color(0xFF2E7DFF)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Texts
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "to HealthConnect !",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ⭐ Get Started Button WITH navigation
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AlreadySignedUpPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Get Started"),
            ),

            const SizedBox(height: 20),

            // Image
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/doctor_patient.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Bottom blue wave
            Container(
              height: 90,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7DFF), Color(0xFF5AA9FF)],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
