import 'package:flutter/material.dart';
import 'package:myjobapp/onboarding_screen.dart';

void main() {
  runApp(const MyJob());
}

class MyJob extends StatelessWidget {
  const MyJob({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScr(),
    );
  }
}
