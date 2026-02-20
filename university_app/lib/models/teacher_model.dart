// lib/models/teacher_model.dart
class Teacher {
  final String name;
  final String designation;
  final String department;
  final String phone;
  final String email;
  final String expertise;

  Teacher({
    required this.name,
    required this.designation,
    required this.department,
    required this.phone,
    required this.email,
    required this.expertise,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      name: json['name'] ?? '',
      designation: json['designation'] ?? '',
      department: json['department'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      expertise: json['expertise'] ?? '',
    );
  }
}
