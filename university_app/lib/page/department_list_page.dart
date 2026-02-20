import 'package:flutter/material.dart';

class DepartmentListPage extends StatelessWidget {
  const DepartmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // এখানে আপনার ডিপার্টমেন্টের লিস্ট
    final List<Map<String, dynamic>> departments = [
      {'name': 'Computer Science', 'code': 'CSE', 'icon': Icons.computer},
      {'name': 'Electrical Engineering', 'code': 'EEE', 'icon': Icons.bolt},
      {
        'name': 'Business Administration',
        'code': 'BBA',
        'icon': Icons.business_center
      },
      {'name': 'Civil Engineering', 'code': 'CE', 'icon': Icons.foundation},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Departments"),
        backgroundColor: const Color(0xFF003366),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: departments.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade50,
                child: Icon(departments[index]['icon'],
                    color: const Color(0xFF003366)),
              ),
              title: Text(departments[index]['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("Code: ${departments[index]['code']}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // ডিপার্টমেন্ট ডিটেইলসে যাওয়ার কোড এখানে হবে
              },
            ),
          );
        },
      ),
    );
  }
}
