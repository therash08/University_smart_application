import 'dart:ui';
import 'package:flutter/material.dart';
import 'department_list_page.dart';
import 'teacher_dept_list_page.dart';
import 'notices_page.dart';
import 'course_list_page.dart';
import '../widgets/end_drawer_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const EndDrawerMenu(),
      body: Stack(
        children: [
          // ১. প্রিমিয়াম ডার্ক ব্যাকগ্রাউন্ড (Obsidian Gradient)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F172A), // খুবই ডার্ক ব্লু-ব্ল্যাক (Slate 900)
                  Color(0xFF1E293B), // একটু হালকা শেড (Slate 800)
                  Color(0xFF0F172A),
                ],
              ),
            ),
          ),

          // ২. ব্যাকগ্রাউন্ডে সফট গ্লো (যাতে স্ক্রিন প্রাণবন্ত লাগে)
          Positioned(
            top: -100,
            right: -50,
            child: _buildBlurBlob(300, Colors.blueAccent.withOpacity(0.15)),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: _buildBlurBlob(250, Colors.indigoAccent.withOpacity(0.15)),
          ),

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ৩. প্রিমিয়াম অ্যাপ বার
              SliverAppBar(
                expandedHeight: 320.0,
                pinned: true,
                backgroundColor: const Color(0xFF0F172A).withOpacity(0.8),
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.white),
                leading: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/images/logo.png',
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.school, color: Colors.white),
                  ),
                ),
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu_open_rounded, size: 30),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/campus.jpg',
                        fit: BoxFit.cover,
                      ),
                      // ডার্ক গ্রেডিয়েন্ট ওভারলে
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              const Color(
                                  0xFF0F172A), // নিচের দিকে ব্যাকগ্রাউন্ডের সাথে মিশে যাবে
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Empowering\nTomorrow's Leaders",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1),
                            ),
                            const SizedBox(height: 10),
                            Container(
                                height: 4, width: 40, color: Colors.blueAccent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ৪. সার্ভিস সেকশন (High Contrast Glass Cards)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Campus Services",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                        children: [
                          _buildPremiumCard(
                              context,
                              "Profile",
                              Icons.person_rounded,
                              Colors.cyanAccent,
                              () => Navigator.pushNamed(context, '/profile')),
                          _buildPremiumCard(
                              context,
                              "Courses",
                              Icons.auto_stories_rounded,
                              Colors.orangeAccent,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CourseListPage()))),
                          _buildPremiumCard(
                              context,
                              "Departments",
                              Icons.account_balance_rounded,
                              Colors.greenAccent,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DepartmentListPage()))),
                          _buildPremiumCard(
                              context,
                              "Teachers",
                              Icons.supervisor_account_rounded,
                              Colors.purpleAccent,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TeacherDeptListPage()))),
                          _buildPremiumCard(
                              context,
                              "Bus Schedule",
                              Icons.directions_bus_rounded,
                              Colors.redAccent,
                              () => Navigator.pushNamed(context, '/crud_demo')),
                          _buildPremiumCard(
                              context,
                              "Notices",
                              Icons.campaign_rounded,
                              Colors.yellowAccent,
                              () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NoticesPage()))),
                          _buildPremiumCard(
                              context,
                              "Support",
                              Icons.headset_mic_rounded,
                              Colors.pinkAccent,
                              () => Navigator.pushNamed(context, '/help')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // প্রিমিয়াম কার্ড ডিজাইন
  Widget _buildPremiumCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05), // সামান্য সাদাটে স্বচ্ছতা
              borderRadius: BorderRadius.circular(24),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // আইকন গ্লো ইফেক্ট (যাতে অন্ধকার ব্যাকগ্রাউন্ডে ফুটে ওঠে)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: color.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color:
                        Colors.white, // টাইটেল একদম সাদা যাতে পরিষ্কার দেখা যায়
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlurBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
