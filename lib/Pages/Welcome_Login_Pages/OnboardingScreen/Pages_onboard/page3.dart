import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                fit: BoxFit.contain,
                'images/customer.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: const Center(
                  child: Text(
                    'Đội ngũ năng động\nHỗ trợ nhiệt tình\nNhận việc nhanh chóng',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
