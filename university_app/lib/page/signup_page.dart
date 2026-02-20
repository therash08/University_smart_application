import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/responsive_wrapper.dart';
import '../services/supabase_service.dart';

class SignupPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Local Asset)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/leading.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.6)),
          ResponsiveWrapper(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: GlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: "Full Name",
                        icon: Icons.person_outline,
                        controller: _nameController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Email",
                        icon: Icons.email_outlined,
                        controller: _emailController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        hintText: "Confirm Password",
                        icon: Icons.lock_outline,
                        isPassword: true,
                        controller: _confirmPassController,
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        text: "Create Account",
                        onPressed: () async {
                          if (_passwordController.text ==
                              _confirmPassController.text) {
                            await SupabaseService().signUp(
                              _emailController.text,
                              _passwordController.text,
                              _nameController.text,
                            );
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Passwords do not match"),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Already have an account? Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
