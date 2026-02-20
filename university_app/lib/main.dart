import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// সব পেজগুলো ইমপোর্ট করা হলো (আপনার ফাইল পাথ অনুযায়ী)
import 'page/splash_page.dart';
import 'page/login_page.dart';
import 'page/signup_page.dart';
import 'page/home_page.dart';
import 'page/profile_page.dart';
import 'page/course_list_page.dart';
import 'page/notices_page.dart';
import 'page/department_list_page.dart';
import 'page/teacher_dept_list_page.dart';
import 'page/help_page.dart';
import 'page/bus_schedule_page.dart';

void main() async {
  // ১. ফ্লার্টার ইঞ্জিন ইনিশিয়ালাইজ করা
  WidgetsFlutterBinding.ensureInitialized();

  // ২. সুপাবেস ইনিশিয়ালাইজ করা (আপনার প্রজেক্টের URL এবং Key)
  await Supabase.initialize(
    url: 'https://civhhaxhexmscsbwkyvx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpdmhoYXhoZXhtc2NzYndreXZ4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NzM3NTAsImV4cCI6MjA4MzU0OTc1MH0.8RIYpXK3Ca9nyTEfCUqreVNd6vvpT_bueN8f21gEcDA',
  );

  runApp(const UniversitySmartApp());
}

class UniversitySmartApp extends StatelessWidget {
  const UniversitySmartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Smart App',
      debugShowCheckedModeBanner: false,

      // ৩. থিম সেটআপ (প্রিমিয়াম ডার্ক থিম)
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark, // পুরো অ্যাপে ডার্ক মুড
        primaryColor: const Color(0xFF0F172A),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F172A),
          brightness: Brightness.dark,
        ),
      ),

      // ৪. প্রথম কোন পেজটি দেখাবে
      initialRoute: '/',

      // ৫. রাউটস ম্যাপিং (নেভিগেশনের জন্য)
      routes: {
        '/': (context) => const SplashPage(), // এটি const থাকতে পারে
        '/login': (context) => LoginPage(), // const কেটে দিন
        '/signup': (context) => SignupPage(), // const কেটে দিন
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/help': (context) => const SupportPage(),
        '/notices': (context) => const NoticesPage(),
        '/courses': (context) => const CourseListPage(),
        '/dept': (context) => const DepartmentListPage(),
        '/teachers': (context) => const TeacherDeptListPage(),
        '/crud_demo': (context) => const BusSchedulePage(),
      },
    );
  }
}
