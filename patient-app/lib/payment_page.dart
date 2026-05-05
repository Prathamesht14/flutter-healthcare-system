import 'package:flutter/material.dart';
import 'navigation_map.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPayment;

  void _onOkPressed() {
    if (selectedPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a payment method")),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const NavigationMapPage()),
    );
  }

  Widget _paymentOption({
    required String title,
    required IconData icon,
    required String value,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedPayment == value
              ? Colors.blue.shade100
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selectedPayment == value ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Colors.blue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Radio<String>(
              value: value,
              groupValue: selectedPayment,
              onChanged: (val) {
                setState(() {
                  selectedPayment = val;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _paymentOption(
              title: "UPI Payment",
              icon: Icons.qr_code,
              value: "upi",
            ),

            _paymentOption(
              title: "Cash on Service",
              icon: Icons.money,
              value: "cash",
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedPayment == null
                    ? Colors.grey
                    : Colors.blue,
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: selectedPayment == null ? null : _onOkPressed,
              child: const Text("OK", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
