import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // Singleton Pattern
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // Supabase Client
  final SupabaseClient client = Supabase.instance.client;

  // --- Auth Methods ---

  // Sign Up
  Future<void> signUp(String email, String password, String fullName) async {
    try {
      await client.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName}, // User Metadata
      );
    } catch (e) {
      throw Exception('Sign Up Failed: $e');
    }
  }

  // Sign In
  Future<void> signIn(String email, String password) async {
    try {
      await client.auth.signInWithPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  // Get Current User Email
  String? getCurrentUserEmail() {
    return client.auth.currentUser?.email;
  }

  // --- Database Methods (Fetch Data) ---

  // ১. কোর্স ফেচ করা
  Future<List<Map<String, dynamic>>> getCourses() async {
    try {
      final response = await client.from('courses').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching courses: $e');
      return [];
    }
  }

  // ২. নোটিশ ফেচ করা
  Future<List<Map<String, dynamic>>> getNotices() async {
    try {
      final response = await client
          .from('notices')
          .select()
          .order('created_at', ascending: false);
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching notices: $e');
      return [];
    }
  }

  // ৩. বাস শিডিউল ফেচ করা
  Future<List<Map<String, dynamic>>> getBusSchedules() async {
    try {
      final response = await client.from('bus_schedules').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching bus schedules: $e');
      return [];
    }
  }
}
