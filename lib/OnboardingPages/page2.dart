import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 150, left: 10, right: 10, bottom: 30),
            child: Image.asset(
              height: 250,
              fit: BoxFit.contain,
              'images/protect.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              'Đảm bảo quyền lợi người lao động \nKhông thu phí dưới mọi hình thức',
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
