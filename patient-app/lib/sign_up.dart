import 'package:flutter/material.dart';
import 'sign.dart';
import 'log_in.dart';

class AlreadySignedUpPage extends StatelessWidget {
  const AlreadySignedUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔵 Top curved blue container
            Container(
              height: 110,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5AA9FF), Color(0xFF2E7DFF)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
              ),
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: const Text(
                "HealthConnect",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🖼 Illustration image
            Image.asset(
              "assets/images/doctor_patient.png", // <-- put your image name
              height: 150,
            ),

            const SizedBox(height: 20),

            // 📝 Text
            const Text(
              "Already\nSigned Up?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            // ✅ Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Yes button (filled)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                    // TODO: navigate to login page
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text("Yes"),
                ),

                const SizedBox(width: 16),

                // No button (outlined)
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpPage(),
                      ),
                    );
                    // TODO: navigate to sign up page
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text("No", style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 🔘 Page indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 18,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // 🔵 Bottom curved blue
            Container(
              height: 90,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7DFF), Color(0xFF5AA9FF)],
                ),
                borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
