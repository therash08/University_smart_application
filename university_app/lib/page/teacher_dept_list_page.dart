import 'dart:ui';
import 'package:flutter/material.dart';
import 'teacher_list_page.dart';

class TeacherDeptListPage extends StatelessWidget {
  const TeacherDeptListPage({super.key});

  final List<Map<String, dynamic>> depts = const [
    {"name": "CSE", "icon": Icons.computer_rounded, "color": Colors.cyanAccent},
    {
      "name": "BBA",
      "icon": Icons.business_center_rounded,
      "color": Colors.orangeAccent
    },
    {
      "name": "English",
      "icon": Icons.menu_book_rounded,
      "color": Colors.greenAccent
    },
    {"name": "Law", "icon": Icons.gavel_rounded, "color": Colors.redAccent},
    {"name": "EEE", "icon": Icons.bolt_rounded, "color": Colors.yellowAccent},
    {
      "name": "Civil",
      "icon": Icons.architecture_rounded,
      "color": Colors.tealAccent
    },
    {"name": "THM", "icon": Icons.hotel_rounded, "color": Colors.purpleAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Teacher Departments",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // ১. প্রিমিয়াম ডার্ক ব্যাকগ্রাউন্ড (Obsidian Theme)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F172A), // Slate 900
                  Color(0xFF1E293B), // Slate 800
                ],
              ),
            ),
          ),

          // ২. ব্যাকগ্রাউন্ড গ্লো (Decorative Blobs)
          Positioned(
            bottom: 100,
            left: -50,
            child: CircleAvatar(
                radius: 120,
                backgroundColor: Colors.blueAccent.withOpacity(0.05)),
          ),

          // ৩. গ্রিড কন্টেন্ট
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85, // কার্ডগুলো একটু লম্বা করার জন্য
            ),
            itemCount: depts.length,
            itemBuilder: (context, index) {
              final dept = depts[index];
              return _buildGlassDeptCard(context, dept);
            },
          ),
        ],
      ),
    );
  }

  // গ্লাস ইফেক্ট ডিপার্টমেন্ট কার্ড
  Widget _buildGlassDeptCard(BuildContext context, Map<String, dynamic> dept) {
    Color accentColor = dept['color'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherListPage(deptName: dept['name']),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(28),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // আইকন গ্লো ইফেক্ট
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Icon(dept['icon'], size: 40, color: accentColor),
                ),
                const SizedBox(height: 15),
                // ডিপার্টমেন্ট নাম
                Text(
                  dept['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                // সাবটাইটেল
                Text(
                  "View Faculty",
                  style: TextStyle(
                    fontSize: 13,
                    color: accentColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
