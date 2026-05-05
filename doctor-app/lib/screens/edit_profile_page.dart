import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final String timeSlot;
  final List<String> workingDays;
  final List<Map<String, String>> services;

  const EditProfilePage({
    super.key,
    required this.timeSlot,
    required this.workingDays,
    required this.services,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late String timeSlot;
  late List<String> selectedDays;
  late List<Map<String, TextEditingController>> services;

  final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  @override
  void initState() {
    super.initState();
    timeSlot = widget.timeSlot;
    selectedDays = List.from(widget.workingDays);

    services = widget.services
        .map(
          (s) => {
            "name": TextEditingController(text: s["name"]),
            "charge": TextEditingController(text: s["charge"]),
          },
        )
        .toList();
  }

  InputDecoration fieldStyle(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xffF1F5F9),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF7FA),
      body: Column(
        children: [
          // 🔵 BLUE HEADER
          Container(
            height: 110,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff2196F3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 48, left: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Edit Profile",
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  /// ⏰ TIME SLOT
                  const Text(
                    "Time Slot",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    initialValue: timeSlot,
                    decoration: fieldStyle("e.g. 10:00 AM - 2:00 PM"),
                    onChanged: (v) => timeSlot = v,
                  ),

                  const SizedBox(height: 22),

                  /// 📅 WORKING DAYS
                  const Text(
                    "Working Days",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    children: days.map((d) {
                      final selected = selectedDays.contains(d);
                      return ChoiceChip(
                        label: Text(d),
                        selected: selected,
                        selectedColor: Colors.blue.shade100,
                        onSelected: (v) {
                          setState(() {
                            v ? selectedDays.add(d) : selectedDays.remove(d);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 25),

                  /// 🛠 SERVICES
                  const Text(
                    "Services",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ...services.asMap().entries.map((entry) {
                    final index = entry.key;
                    final row = entry.value;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: row["name"],
                              decoration: fieldStyle("Service"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: row["charge"],
                              keyboardType: TextInputType.number,
                              decoration: fieldStyle("₹"),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: services.length == 1
                                ? null
                                : () {
                                    setState(() {
                                      services.removeAt(index);
                                    });
                                  },
                          ),
                        ],
                      ),
                    );
                  }),

                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        services.add({
                          "name": TextEditingController(),
                          "charge": TextEditingController(),
                        });
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text(
                      "Add Service",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// 💾 SAVE BUTTON (CENTER, BLUE)
                  Center(
                    child: SizedBox(
                      width: 160,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, {
                            "timeSlot": timeSlot,
                            "workingDays": selectedDays,
                            "services": services
                                .map(
                                  (s) => {
                                    "name": s["name"]!.text,
                                    "charge": s["charge"]!.text,
                                  },
                                )
                                .toList(),
                          });
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
