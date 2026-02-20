class Course {
  final String title;
  final String code;
  final String department;
  final String credits;

  Course({
    required this.title,
    required this.code,
    required this.department,
    required this.credits,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'] ?? 'Unknown Course',
      code: json['code'] ?? 'N/A',
      department: json['department'] ?? 'N/A',
      credits: json['credits']?.toString() ?? '0',
    );
  }
}
