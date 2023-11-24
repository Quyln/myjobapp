import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
                'images/worker.png',
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 160,
              child: const Center(
                child: Text(
                  'Hơn 200 việc làm mới mỗi ngày\nVà hàng trăm lao động nhận việc',
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
