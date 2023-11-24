import 'package:flutter/material.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                fit: BoxFit.contain,
                'images/protect.png',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: const Center(
                child: Text(
                  'Đảm bảo quyền lợi người lao động \nKhông thu phí dưới mọi hình thức',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
