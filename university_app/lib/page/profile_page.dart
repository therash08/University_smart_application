import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _supabase = Supabase.instance.client;
  String? userName;
  String? userEmail;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // সুপাবেস থেকে লগইন করা ইউজারের ডাটা ফেচ করা
  void _loadUserData() {
    final user = _supabase.auth.currentUser;
    if (user != null) {
      setState(() {
        // যদি সাইন-আপ করার সময় 'full_name' মেটাডাটাতে দিয়ে থাকেন
        userName = user.userMetadata?['full_name'] ?? "User Name";
        userEmail = user.email;
        userRole = "Student"; // আপনি চাইলে ডাটাবেস থেকেও রোল আনতে পারেন
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // প্রিমিয়াম ডার্ক ব্যাকগ্রাউন্ড
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          ),
        ),
        child: Stack(
          children: [
            // ব্যাকগ্রাউন্ড গ্লো
            Positioned(
              top: -100,
              left: -50,
              child: CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.blueAccent.withOpacity(0.1)),
            ),

            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // অ্যাপ বার বা ব্যাক বাটন
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text("My Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const Icon(Icons.settings, color: Colors.white70),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // প্রোফাইল পিকচার (Premium Look)
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Colors.cyanAccent,
                                Colors.blueAccent
                              ])),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: const Color(0xFF1E293B),
                            child: Text(
                              userName != null
                                  ? userName![0].toUpperCase()
                                  : "U",
                              style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.cyanAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                            child: const Icon(Icons.edit,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // নাম এবং রোল
                  Text(userName ?? "Loading...",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(userRole ?? "Student",
                      style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 16,
                          letterSpacing: 1.5)),

                  const SizedBox(height: 40),

                  // প্রোফাইল ইনফো কার্ডস (Glassmorphism)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        children: [
                          _buildInfoCard("Full Name", userName ?? "Loading...",
                              Icons.person_outline),
                          _buildInfoCard("Email Address",
                              userEmail ?? "Loading...", Icons.email_outlined),
                          _buildInfoCard(
                              "Student ID / Role",
                              "202100100 (Sample)",
                              Icons
                                  .badge_outlined), // আইডি ডাটাবেসে থাকলে সেটি দিতে পারেন

                          const SizedBox(height: 30),

                          // এডিট বাটন
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                            child: const Text("Edit Profile Information",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),

                          const SizedBox(height: 15),

                          // লগআউট বাটন
                          TextButton(
                            onPressed: () async {
                              await _supabase.auth.signOut();
                              Navigator.pushReplacementNamed(
                                  context, '/login'); // লগইন পেজে পাঠিয়ে দিবে
                            },
                            child: const Text("Log Out",
                                style: TextStyle(
                                    color: Colors.redAccent, fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // গ্লাস কার্ড উইজেট
  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyanAccent, size: 28),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(color: Colors.white54, fontSize: 13)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
