import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoticesPage extends StatelessWidget {
  const NoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // দুটি ট্যাব: ১. সাধারণ নোটিশ, ২. ইউনিভার্সিটি গাইড
      child: Scaffold(
        appBar: AppBar(
          title: const Text("University Notices"),
          backgroundColor: const Color(0xFF003366),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Colors.orange,
            tabs: [
              Tab(text: "Recent Notices", icon: Icon(Icons.campaign)),
              Tab(text: "University Guide", icon: Icon(Icons.info)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildDynamicNotices(), // সুপাবেস থেকে আসবে
            _buildUniversityGuide(), // আপনার দেওয়া তথ্যগুলো
          ],
        ),
      ),
    );
  }

  // ট্যাব ১: সুপাবেস থেকে নোটিশ লোড করা
  Widget _buildDynamicNotices() {
    return FutureBuilder(
      future:
          Supabase.instance.client.from('notices').select().order('created_at'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(child: Text("No recent notices found."));
        }

        final notices = snapshot.data as List;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: notices.length,
          itemBuilder: (context, index) {
            final notice = notices[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.description, color: Colors.blue),
                title: Text(notice['title'] ?? 'Notice'),
                subtitle: Text(notice['description'] ?? ''),
                trailing: Text(notice['date'] ?? ''),
              ),
            );
          },
        );
      },
    );
  }

  // ট্যাব ২: আপনার দেওয়া স্থায়ী তথ্যগুলো (Guide/Calendar)
  Widget _buildUniversityGuide() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionHeader("Academic Calendar 2026"),
        _buildStaticNotice("January", "• 24 Jan: Saraswati Puja (Holiday)"),
        _buildStaticNotice("February",
            "• 04 Feb: Shab-e-Barat\n• 21 Feb: Mother Language Day"),
        _buildStaticNotice("March",
            "• 17 Mar: Bangabandhu's Birthday\n• 19-21 Mar: Eid-ul-Fitr*\n• 26 Mar: Independence Day"),
        const SizedBox(height: 20),
        _buildSectionHeader("Academic Rules"),
        _buildExpansionInfo("Attendance Rule",
            "৭০% উপস্থিতি বাধ্যতামূলক। ৬০-৭০% এর নিচে থাকলে জরিমানা দিতে হয়।"),
        _buildExpansionInfo("Add/Drop Week",
            "সেমিস্টার শুরুর ১ম বা ২য় সপ্তাহে কোর্স পরিবর্তন বা বাদ দেওয়ার সুযোগ থাকে।"),
        _buildExpansionInfo(
            "ID Card Policy", "ক্যাম্পাসে আইডি কার্ড ঝোলানো বাধ্যতামূলক।"),
        _buildExpansionInfo("Tuition Fee",
            "১ম ইনস্টলমেন্ট পেমেন্ট ডেডলাইন মেনে দিন। বিকাশ/রকেট/ব্যাংকে পেমেন্ট করা যায়।"),
      ],
    );
  }

  // হেল্পার উইজেটগুলো
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003366))),
    );
  }

  Widget _buildStaticNotice(String month, String details) {
    return Card(
      color: Colors.blue.shade50,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(month, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details),
      ),
    );
  }

  Widget _buildExpansionInfo(String title, String desc) {
    return ExpansionTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(desc, style: const TextStyle(color: Colors.black87)),
        )
      ],
    );
  }
}
