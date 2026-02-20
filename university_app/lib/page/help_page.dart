import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // কল বা মেইল করার জন্য (অপশনাল)

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  // কল করার ফাংশন
  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  // মেইল করার ফাংশন
  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Support"),
        backgroundColor: const Color(0xFF003366),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // উপরের আইকন
            const Center(
              child: Icon(
                Icons.support_agent_rounded,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "How can we help you?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),

            // আইটেম লিস্ট
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // কল সেকশন
                  _buildSupportItem(
                    icon: Icons.phone_in_talk_rounded,
                    title: "Call IT Support",
                    subtitle: "+880 1610624584",
                    onTap: () => _makeCall("+8801610624584"),
                  ),
                  const Divider(height: 40),

                  // ইমেইল সেকশন
                  _buildSupportItem(
                    icon: Icons.email_outlined,
                    title: "Email Administration",
                    subtitle: "therash792@gmail.com",
                    onTap: () => _sendEmail("therash792@gmail.com"),
                  ),
                  const Divider(height: 40),

                  // অফিস সেকশন
                  _buildSupportItem(
                    icon: Icons.location_on_outlined,
                    title: "Visit IT Office",
                    subtitle: "Electric Supply Road, Amborkhana",
                    onTap: () {
                      // এখানে ম্যাপ ওপেন করার লজিক দিতে পারেন
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // সাপোর্ট আইটেম ডিজাইন
  Widget _buildSupportItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.grey[700]),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
