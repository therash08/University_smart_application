import 'package:flutter/material.dart';
import '../widgets/app_appbar.dart';
import '../widgets/end_drawer_menu.dart';
import '../widgets/responsive_wrapper.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: "Help & Support"),
      endDrawer: const EndDrawerMenu(),
      body: ResponsiveWrapper(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Icon(Icons.support_agent, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "How can we help you?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Call IT Support"),
                subtitle: const Text("+880 1234 567890"),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text("Email Administration"),
                subtitle: const Text("admin@leading.edu.bd"),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Visit IT Office"),
                subtitle: const Text("Building B, 3rd Floor"),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
