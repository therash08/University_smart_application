import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final _future = Supabase.instance.client.from('courses').select();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Courses")),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = snapshot.data as List<dynamic>;

          if (courses.isEmpty) {
            return const Center(child: Text("No courses found"));
          }

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                title: Text(course['title']),
                subtitle: Text(
                    "Code: ${course['code']} | Credits: ${course['credits']}"),
                leading: const Icon(Icons.book, color: Colors.orange),
              );
            },
          );
        },
      ),
    );
  }
}
