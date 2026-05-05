import 'package:flutter/material.dart';
import 'home_page.dart'; // make sure this contains MapPage

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Change Your Password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "New password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm password",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // ✅ Navigate to Home Page
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MapPage()),
                    (route) => false,
                  );
                },
                child: const Text("Reset Password"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
