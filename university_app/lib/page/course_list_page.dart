import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_model.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({super.key});

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  Future<List<Course>> fetchCourses() async {
    try {
      final response = await Supabase.instance.client
          .from('courses')
          .select()
          .order('code', ascending: true);

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load courses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Available Courses",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
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

          Positioned(
            top: 100,
            right: -50,
            child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.orangeAccent.withOpacity(0.05)),
          ),

          // ৩. মেইন কন্টেন্ট
          FutureBuilder<List<Course>>(
            future: fetchCourses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.orangeAccent));
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text("Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.white70)));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text("No courses found.",
                        style: TextStyle(color: Colors.white70)));
              }

              final courses = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 120, 16, 20),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return _buildGlassCourseCard(course);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCourseCard(Course course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.menu_book_rounded,
                      color: Colors.orangeAccent, size: 28),
                ),
                const SizedBox(width: 16),

                // মাঝের তথ্য
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.cyanAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Colors.cyanAccent.withOpacity(0.3)),
                            ),
                            child: Text(
                              course.code,
                              style: const TextStyle(
                                  color: Colors.cyanAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Dept: ${course.department}",
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Text(
                      "${course.credits} CR",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white24, size: 14),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
