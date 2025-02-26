import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({required this.verificationId, super.key});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(verificationId),
            ],
          ),
        ),
      ),
    );
  }
}
