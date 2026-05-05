import 'package:flutter/material.dart';
import 'package:healthconnect/screens/forgot_password_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🔵 TOP BLUE CURVE WITH BACK ARROW
              Container(
                height: 90,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF4AAFFF),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.only(top: 45, left: 10, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⬅ BACK ARROW
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 22,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        
                      },
                    ),

                    const SizedBox(width: 8),

                    // 🏥 TITLE
                    const Text(
                      "HealthConnect",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 🟦 TITLE
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007BFF),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Log in to your account",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // 📧 EMAIL FIELD
              _inputField(
                hint: "Email",
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                      .hasMatch(value)) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // 🔒 PASSWORD FIELD
              _inputField(
                hint: "Password",
                controller: passwordController,
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),

                             const SizedBox(height: 16),

Center(
  child: TextButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ForgotPasswordPage(),
        ),
      );
    },
    child: const Text(
      "Forgot Password?",
      style: TextStyle(
        color: Color(0xFF007BFF),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
),


              const SizedBox(height: 25),

              // 🔵 LOGIN BUTTON
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007BFF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 40),

              // 🟦 BOTTOM CURVE
          
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 INPUT FIELD WITH VALIDATION
  Widget _inputField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFF00A3FF),
          hintStyle: const TextStyle(color: Colors.white),
          errorStyle: const TextStyle(color: Colors.redAccent),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
