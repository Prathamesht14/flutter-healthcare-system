import 'package:flutter/material.dart';
import 'home_page.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // -------- TOP CURVE --------
            ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                height: 140,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: const Color(0xFF0A84FF),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Personal Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // -------- FORM --------
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  children: [
                    buildField(
                      controller: nameController,
                      hint: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    buildField(
                      controller: ageController,
                      hint: "Age",
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Age is required";
                        }
                        final age = int.tryParse(value);
                        if (age == null || age <= 0 || age > 120) {
                          return "Enter valid age";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    buildField(
                      controller: phoneController,
                      hint: "Phone no.",
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Phone number is required";
                        }
                        if (value.length != 10) {
                          return "Enter 10 digit phone number";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    buildField(
                      controller: addressController,
                      hint: "Address",
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Address is required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40),

                    // -------- SAVE BUTTON --------
                    Center(
                      child: SizedBox(
                        width: 160,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Details saved successfully"),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapPage(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // -------- BOTTOM CURVE --------
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: 90,
                width: double.infinity,
                color: const Color(0xFF0A84FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------- COMMON TEXT FIELD --------
  Widget buildField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// -------- TOP CURVE --------
class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 30,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// -------- BOTTOM CURVE --------
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 30);
    path.quadraticBezierTo(size.width / 2, 0, size.width, 30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
