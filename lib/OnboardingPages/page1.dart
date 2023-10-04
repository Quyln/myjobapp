import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 150, left: 10, right: 10, bottom: 30),
            child: Image.asset(
              height: 250,
              fit: BoxFit.contain,
              'images/jobs.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              'Mỗi ngày với hơn 200 việc làm mới và hàng trăm lao động nhận việc.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
