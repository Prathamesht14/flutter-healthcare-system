import 'package:flutter/material.dart';
import 'profile.dart';
import 'doctor_page.dart';
import 'history_page.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // -------- APP BAR --------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 113, 243),
        elevation: 0,
        automaticallyImplyLeading: false,

        // ---- HOME TEXT ----
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'profile') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile clicked")),
                );
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
            itemBuilder: (context) => const [
              PopupMenuItem<String>(value: 'profile', child: Text("Profile")),
            ],
          ),
        ],
      ),

      body: Column(
        children: [
          // -------- MAP AREA --------
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(
                child: Text("Map View", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),

          // -------- BOTTOM BUTTONS --------
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DoctorPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text("Doctor"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text("History"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
