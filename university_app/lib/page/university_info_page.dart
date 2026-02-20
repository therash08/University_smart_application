import 'package:flutter/material.dart';

class UniversityInfoPage extends StatelessWidget {
  const UniversityInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        title: const Text("University Guide & Calendar"),
        backgroundColor: const Color(0xFF003366),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- সেকশন ১: একাডেমিক ক্যালেন্ডার ২০২৬ ---
          _buildHeader("Academic Calendar 2026", Icons.calendar_month),
          _buildInfoCard(
            "January 2026",
            "• 24 Jan (Sat): Saraswati Puja (Optional Holiday)",
            Colors.blue,
          ),
          _buildInfoCard(
            "February 2026",
            "• 04 Feb (Wed): Shab-e-Barat*\n• 21 Feb (Sat): Int. Mother Language Day",
            Colors.blue,
          ),
          _buildInfoCard(
            "March 2026",
            "• 17 Mar (Tue): Sheikh Mujibur Rahman's Birthday\n• 19-21 Mar: Eid-ul-Fitr Holidays*\n• 26 Mar (Thu): Independence Day",
            Colors.blue,
          ),
          _buildInfoCard(
            "April 2026",
            "• 14 Apr (Tue): Pohela Boishakh",
            Colors.blue,
          ),

          const SizedBox(height: 20),

          // --- সেকশন ২: একাডেমিক গাইড (ExpansionTile ব্যবহার করা হয়েছে) ---
          _buildHeader("Academic Guide", Icons.school),
          _buildExpansionTile(
            "Course Add/Drop Week",
            "স্প্রিং সেমিস্টার শুরু হওয়ার প্রথম বা দ্বিতীয় সপ্তাহে সুযোগ থাকে। সেকশন পরিবর্তন বা কোর্স বাদ দিতে ডিপার্টমেন্টের নোটিশ বোর্ড খেয়াল রাখুন।",
            Icons.swap_horiz,
          ),
          _buildExpansionTile(
            "Tuition Fee & Installments",
            "সেমিস্টার শুরুতে ১ম ইনস্টলমেন্ট বা রেজিস্ট্রেশন ফি লেট ফি ছাড়া দিতে পেমেন্ট ডেট জেনে নিন। পেমেন্ট: বিকাশ, রকেট বা ব্যাংক।",
            Icons.payments_outlined,
          ),
          _buildExpansionTile(
            "Club Recruitment",
            "Cultural, Debating, Computer Club নতুন সদস্য নেয়। এক্সট্রা কারিকুলার অ্যাক্টিভিটিজের জন্য এটি সেরা সময়।",
            Icons.groups_outlined,
          ),

          const SizedBox(height: 20),

          // --- সেকশন ৩: জরুরি নিয়মাবলী ---
          _buildHeader("Important Rules", Icons.gavel),
          _buildInfoCard(
            "70% Attendance Rule",
            "উপস্থিতি ৬০-৭০% এর নিচে থাকলে ফাইনালে বসতে দেওয়া হয় না বা জরিমানা (Non-collegiate fee) দিতে হয়।",
            Colors.red,
          ),
          _buildInfoCard(
            "Mandatory ID Card",
            "ক্যাম্পাসে প্রবেশের সময় আইডি কার্ড ঝোলানো বাধ্যতামূলক (বিশেষ করে নিরাপত্তা জোরদার করার পর থেকে)।",
            Colors.orange,
          ),
        ],
      ),
    );
  }

  // হেডার ডিজাইন
  Widget _buildHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF003366)),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366)),
          ),
        ],
      ),
    );
  }

  // সাধারণ কার্ড ডিজাইন (Calendar & Rules এর জন্য)
  Widget _buildInfoCard(String title, String content, Color accentColor) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: accentColor.withOpacity(0.3))),
      child: ListTile(
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, color: accentColor)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(content,
              style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ),
      ),
    );
  }

  // ড্রপডাউন (Expansion) কার্ড ডিজাইন (Academic Guide এর জন্য)
  Widget _buildExpansionTile(String title, String content, IconData icon) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(content,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
