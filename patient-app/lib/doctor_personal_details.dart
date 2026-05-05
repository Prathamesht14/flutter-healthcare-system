import 'package:flutter/material.dart';
import 'package:myy_app/appointment_details_page.dart';

class DoctorPersonalDetailsPage extends StatefulWidget {
  const DoctorPersonalDetailsPage({super.key});

  @override
  State<DoctorPersonalDetailsPage> createState() =>
      _DoctorPersonalDetailsPageState();
}

class _DoctorPersonalDetailsPageState extends State<DoctorPersonalDetailsPage> {
  bool dailyCheckup = false;
  bool bloodTest = false;
  bool generalTest = false;

  int totalAmount = 0;

  void calculateTotal() {
    int sum = 0;
    if (dailyCheckup) sum += 500;
    if (bloodTest) sum += 300;
    if (generalTest) sum += 250;

    setState(() {
      totalAmount = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- HEADER ----------
            Container(
              height: 120,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ---------- BACK BUTTON ----------
                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 26,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    // ---------- TITLE ----------
                    const Text(
                      "Doctor Personal Details",
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

            const SizedBox(height: 20),

            // ---------- BASIC INFO ----------
            sectionTitle("Basic Information"),
            inputBox("Full Name"),
            inputBox("Mobile Number"),
            inputBox("Email ID"),

            const SizedBox(height: 15),

            // ---------- EDUCATION ----------
            sectionTitle("Education & Qualification"),
            inputBox("Degree"),
            inputBox("Specialization"),
            inputBox("Experience"),

            const SizedBox(height: 15),

            // ---------- SERVICES ----------
            sectionTitle("Services"),

            serviceRow("Daily Checkup", 500, dailyCheckup, (value) {
              dailyCheckup = value!;
              calculateTotal();
            }),

            serviceRow("Blood Test", 300, bloodTest, (value) {
              bloodTest = value!;
              calculateTotal();
            }),

            serviceRow("General Test", 250, generalTest, (value) {
              generalTest = value!;
              calculateTotal();
            }),

            const SizedBox(height: 15),

            // ---------- TOTAL ----------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹ $totalAmount",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ---------- APPOINTMENT BUTTON ----------
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: totalAmount == 0 ? Colors.grey : Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              onPressed: totalAmount == 0
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AppointmentDetailsPage(),
                        ),
                      );
                    },
              child: const Text("Appointment", style: TextStyle(fontSize: 16)),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= WIDGETS =================

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget inputBox(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(hint, style: const TextStyle(color: Colors.black54)),
      ),
    );
  }

  Widget serviceRow(
    String title,
    int price,
    bool value,
    Function(bool?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title   ₹$price"),
          Checkbox(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
