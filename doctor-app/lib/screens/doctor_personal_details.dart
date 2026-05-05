import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'home_page.dart';

class DoctorPersonalDetails extends StatefulWidget {
  const DoctorPersonalDetails({super.key});

  @override
  State<DoctorPersonalDetails> createState() => _DoctorPersonalDetailsState();
}

class _DoctorPersonalDetailsState extends State<DoctorPersonalDetails> {
  final _formKey = GlobalKey<FormState>();

  /// DEGREE
  String? selectedDegree;
  bool isOtherDegree = false;
  final TextEditingController degreeController = TextEditingController();

  final degrees = ["MBBS", "MD", "BDS", "BHMS", "BAMS", "Other"];
  final experiences = ["0-2 Years", "3-5 Years", "5+ Years"];
  String? selectedExperience;

  /// DAYS
  final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
  List<String> selectedDays = [];

  /// TIME
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  /// SERVICES
  List<Map<String, TextEditingController>> services = [
    {"service": TextEditingController(), "charge": TextEditingController()},
  ];
  String serviceError = "";

  /// ERRORS
  String daysError = "";
  String certificateError = "";
  String timeError = "";

  /// CERTIFICATE
  PlatformFile? selectedCertificate;

  InputDecoration inputStyle(String hint) => InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      );

  Widget sectionTitle(String text) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      );

  Future<void> pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        isStart ? startTime = picked : endTime = picked;
      });
    }
  }

  /// PICK ONLY PDF
  Future<void> pickCertificate() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedCertificate = result.files.first;
          certificateError = "";
        });
      }
    } catch (e) {
      setState(() {
        certificateError = "Failed to pick file";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER
            Container(
              height: 95,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff6EC6FF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 35, left: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
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

            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// BASIC INFO
                    sectionTitle("Basic Information"),
                    TextFormField(
                      decoration: inputStyle("Full Name"),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      decoration: inputStyle("Mobile Number"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (v) => RegExp(r'^\d{10}$').hasMatch(v ?? "")
                          ? null
                          : "Enter 10-digit number",
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      decoration: inputStyle("Email ID"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => RegExp(
                        r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(v ?? "")
                          ? null
                          : "Enter valid email",
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      decoration: inputStyle("License Number"),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),

                    const SizedBox(height: 20),

                    /// DOCTOR VERIFICATION
                    sectionTitle("Doctor Verification"),

                    InkWell(
                      onTap: pickCertificate,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.upload_file, color: Colors.blue),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                selectedCertificate == null
                                    ? "Upload Degree / License Certificate (PDF)"
                                    : selectedCertificate!.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: selectedCertificate == null
                                      ? Colors.black
                                      : Colors.green.shade700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (certificateError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          certificateError,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    const SizedBox(height: 24),

                    /// EDUCATION
                    sectionTitle("Education & Qualification"),

                    isOtherDegree
                        ? TextFormField(
                            controller: degreeController,
                            decoration: inputStyle("Enter Degree"),
                            validator: (v) =>
                                v!.isEmpty ? "Degree required" : null,
                          )
                        : DropdownButtonFormField(
                            decoration: inputStyle("Degree"),
                            items: degrees
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              setState(() {
                                if (v == "Other") {
                                  isOtherDegree = true;
                                } else {
                                  selectedDegree = v;
                                }
                              });
                            },
                            validator: (v) =>
                                v == null ? "Select degree" : null,
                          ),

                    const SizedBox(height: 12),

                    DropdownButtonFormField(
                      decoration: inputStyle("Experience"),
                      items: experiences
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => selectedExperience = v,
                      validator: (v) => v == null ? "Select experience" : null,
                    ),

                    /// AVAILABILITY
                    sectionTitle("Availability (Days)"),
                    Wrap(
                      spacing: 8,
                      children: days.map((d) {
                        final selected = selectedDays.contains(d);
                        return ChoiceChip(
                          label: Text(d),
                          selected: selected,
                          onSelected: (v) {
                            setState(() {
                              v
                                  ? selectedDays.add(d)
                                  : selectedDays.remove(d);
                              daysError = "";
                            });
                          },
                        );
                      }).toList(),
                    ),

                    if (daysError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          daysError,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    /// TIME SLOT
                    sectionTitle("Time Slot"),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => pickTime(true),
                            child: InputDecorator(
                              decoration: inputStyle("Start Time"),
                              child: Text(
                                startTime?.format(context) ?? "Start Time",
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () => pickTime(false),
                            child: InputDecorator(
                              decoration: inputStyle("End Time"),
                              child: Text(
                                endTime?.format(context) ?? "End Time",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (timeError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          timeError,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    /// SERVICES
                    sectionTitle("Services & Charges"),
                    ...services.map((row) {
                      final index = services.indexOf(row);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: row["service"],
                                decoration: inputStyle("Service"),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: row["charge"],
                                keyboardType: TextInputType.number,
                                decoration: inputStyle("₹"),
                              ),
                            ),
                            if (index == services.length - 1)
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    services.add({
                                      "service": TextEditingController(),
                                      "charge": TextEditingController(),
                                    });
                                  });
                                },
                              ),
                          ],
                        ),
                      );
                    }),

                    if (serviceError.isNotEmpty)
                      Text(
                        serviceError,
                        style: const TextStyle(color: Colors.red),
                      ),

                    const SizedBox(height: 30),

                    /// SAVE
                    Center(
                      child: SizedBox(
                        width: 160,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              serviceError = "";
                              daysError = "";
                              certificateError = "";
                              timeError = "";
                            });

                            if (!_formKey.currentState!.validate()) return;

                            if (selectedDays.length < 2) {
                              setState(() {
                                daysError = "Select at least 2 working days";
                              });
                              return;
                            }

                            if (startTime == null || endTime == null) {
                              setState(() {
                                timeError = "Select both start and end time";
                              });
                              return;
                            }

                            if (selectedCertificate == null) {
                              setState(() {
                                certificateError =
                                    "Upload your degree/license certificate (PDF)";
                              });
                              return;
                            }

                            if (services.first["service"]!.text.isEmpty) {
                              setState(() {
                                serviceError =
                                    "At least one service is required";
                              });
                              return;
                            }

                            // SUCCESS
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomePage(),
                              ),
                            );
                          },
                          child: const Text("Save"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
