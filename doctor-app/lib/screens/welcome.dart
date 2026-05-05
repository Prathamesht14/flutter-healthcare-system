import 'package:flutter/material.dart';
import 'package:healthconnect/screens/already_signed_up.dart';
import 'forgot_password_page.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            /// 🔵 Top right blue curve
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                height: 160,
                width: 160,
                decoration: const BoxDecoration(
                  color: Color(0xFF3FA9F5),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(160),
                  ),
                ),
              ),
            ),

            /// 🔵 Bottom blue wave
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                decoration: const BoxDecoration(
                  color: Color(0xFF6EC6FF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
              ),
            ),

            /// 🔵 Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 90),

                  /// Title text
                  const Text(
                    "Welcome\nto HealthConnect !",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),

                  const SizedBox(height: 45),

                  /// Get Started button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlreadySignedUpPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007BFF),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 42,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),

 

                  const SizedBox(height: 40),

                  /// Doctor illustration
                  Center(
                    child: Image.asset(
                      "assets/images/doctor_patient.png",
                      height: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
