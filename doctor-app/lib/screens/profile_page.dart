import 'package:flutter/material.dart';
import 'already_signed_up.dart';
import 'edit_profile_page.dart';
import 'home_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
File? profileImage;
final ImagePicker _picker = ImagePicker();

class _ProfilePageState extends State<ProfilePage> {
  // DISPLAY DATA
  String fullName = "Dr.Jadhav";
  String mobile = "9876543210";
  String email = "doctor@email.com";

  String timeSlot = "10:00 AM - 2:00 PM";
  List<String> workingDays = ["Mon", "Tue", "Thu"];

  List<Map<String, String>> services = [
    {"name": "General Checkup", "charge": "300"},
    {"name": "Home Visit", "charge": "600"},
  ];

  Widget greyBox(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }
  Future<void> pickImage() async {
  final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      profileImage = File(pickedFile.path);
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF7FA),
      body: Column(
        children: [
          // 🔵 HEADER
          Container(
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xff2196F3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // 👤 PROFILE IMAGE
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
  radius: 55,
  backgroundColor: Colors.grey,
  backgroundImage:
      profileImage != null ? FileImage(profileImage!) : null,
  child: profileImage == null
      ? const Icon(Icons.person, size: 50, color: Colors.white)
      : null,
),

                    GestureDetector(
  onTap: pickImage,
  child: Container(
    padding: const EdgeInsets.all(6),
    decoration: const BoxDecoration(
      color: Colors.blue,
      shape: BoxShape.circle,
    ),
    child: const Icon(
      Icons.camera_alt,
      color: Colors.white,
      size: 18,
    ),
  ),
),

                    ],
                  ),

                  const SizedBox(height: 25),

                  // 🧾 BASIC INFO (DISPLAY ONLY)
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Basic Information",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  greyBox(fullName),
                  greyBox(mobile),
                  greyBox(email),

                  const SizedBox(height: 25),

                  // ⏰ AVAILABILITY
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Availability",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(
                                  timeSlot: timeSlot,
                                  workingDays: workingDays,
                                  services: services,
                                ),
                              ),
                            );

                            if (result != null) {
                              setState(() {
                                timeSlot = result["timeSlot"];
                                workingDays = result["workingDays"];
                                services = result["services"];
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  greyBox("Time: $timeSlot"),
                  greyBox("Days: ${workingDays.join(', ')}"),

                  const SizedBox(height: 25),

                  // 🛠 SERVICES
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Services",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  ...services.map(
                    (s) => greyBox("${s["name"]}      ₹${s["charge"]}"),
                  ),

                  const SizedBox(height: 35),

                  // 🔴 LOGOUT
                  SizedBox(
                    width: 180,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AlreadySignedUpPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}