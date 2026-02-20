import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final double opacity;

  const GlassCard({super.key, required this.child, this.opacity = 0.2});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            // Updated to withValues
            color: Colors.white.withValues(alpha: opacity),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              // Updated to withValues
              color: Colors.white.withValues(alpha: 0.3),
            ),
            boxShadow: [
              BoxShadow(
                // Updated to withValues
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
