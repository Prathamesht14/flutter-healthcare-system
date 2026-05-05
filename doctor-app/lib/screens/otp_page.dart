import 'dart:async';
import 'package:flutter/material.dart';
import 'package:healthconnect/screens/reset_password_page.dart';
import 'reset_password_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final String dummyOtp = "1234";

  int secondsLeft = 30;
  Timer? timer;

  String errorMessage = "";

  final List<TextEditingController> controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    secondsLeft = 30;
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (secondsLeft > 0) {
        setState(() => secondsLeft--);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void verifyOtp() {
    String enteredOtp = controllers.map((c) => c.text).join();

    if (enteredOtp.length < 4) {
      setState(() {
        errorMessage = "Please enter 4-digit OTP";
      });
      return;
    }

    if (enteredOtp == dummyOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
      );
    } else {
      setState(() {
        errorMessage = "Invalid OTP";
      });

      for (var c in controllers) {
        c.clear();
      }

      FocusScope.of(context).requestFocus(focusNodes[0]);
    }
  }

  void resendOtp() {
    if (secondsLeft == 0) {
      setState(() {
        errorMessage = "";
      });

      startTimer();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("OTP Resent")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 🔵 HEADER WITH BACK BUTTON
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 20, bottom: 25),
                alignment: Alignment.bottomLeft,
                decoration: const BoxDecoration(
                  color: Color(0xFF1877F2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: const Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// 🔙 BACK BUTTON
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          /// 🔢 OTP BOXES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 55,
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 3) {
                        FocusScope.of(
                          context,
                        ).requestFocus(focusNodes[index + 1]);
                      } else {
                        FocusScope.of(context).unfocus();
                      }
                    } else {
                      if (index > 0) {
                        FocusScope.of(
                          context,
                        ).requestFocus(focusNodes[index - 1]);
                      }
                    }
                  },
                ),
              );
            }),
          ),

          const SizedBox(height: 12),

          /// ❌ ERROR MESSAGE
          if (errorMessage.isNotEmpty)
            Text(errorMessage, style: const TextStyle(color: Colors.red)),

          const SizedBox(height: 20),

          /// ⏳ RESEND OTP
          GestureDetector(
            onTap: resendOtp,
            child: Text(
              secondsLeft > 0 ? "Resend OTP in $secondsLeft sec" : "Resend OTP",
              style: TextStyle(
                color: secondsLeft > 0 ? Colors.grey : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          /// 🔵 SMALL VERIFY BUTTON
          SizedBox(
            width: 160,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1877F2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: verifyOtp,
              child: const Text(
                "Verify OTP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}