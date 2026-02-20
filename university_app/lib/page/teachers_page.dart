import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  // Supabase থেকে টিচারদের ডাটা রিড করার Future
  final _future = Supabase.instance.client
      .from('teachers')
      .select()
      .order('name', ascending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teacher Information"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final teachers = snapshot.data as List<dynamic>;

          if (teachers.isEmpty) {
            return const Center(child: Text("No teachers found."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: teachers.length,
            itemBuilder: (context, index) {
              final teacher = teachers[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.indigo.shade100,
                    child: const Icon(Icons.person,
                        size: 35, color: Colors.indigo),
                  ),
                  title: Text(
                    teacher['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${teacher['designation']} - ${teacher['department']}"),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.email, size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(teacher['email'] ?? "No email"),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(teacher['phone'] ?? "No phone"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
