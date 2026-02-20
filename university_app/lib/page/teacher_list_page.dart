// lib/page/teacher_list_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/teacher_model.dart'; // মডেলটি ইমপোর্ট করুন

class TeacherListPage extends StatefulWidget {
  final String deptName;
  const TeacherListPage({super.key, required this.deptName});

  @override
  State<TeacherListPage> createState() => _TeacherListPageState();
}

class _TeacherListPageState extends State<TeacherListPage> {
  Future<List<Teacher>> fetchTeachers() async {
    try {
      final response = await Supabase.instance.client
          .from('teachers')
          .select()
          .eq('department', widget.deptName);

      final List<dynamic> data = response as List<dynamic>;
      return data.map((json) => Teacher.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error loading teachers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.deptName} Faculty"),
        backgroundColor: const Color(0xFF003366),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Teacher>>(
        future: fetchTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No teachers found."));
          }

          final teachers = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(teacher.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle:
                      Text("${teacher.designation}\nExp: ${teacher.expertise}"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
