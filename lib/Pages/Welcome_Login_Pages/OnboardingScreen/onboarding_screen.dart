import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/Login_Reg_Screen/login_sceen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Pages_onboard/page1.dart';
import 'Pages_onboard/page2.dart';
import 'Pages_onboard/page3.dart';

class OnboardingScr extends StatefulWidget {
  const OnboardingScr({super.key});

  @override
  State<OnboardingScr> createState() => _OnboardingScrState();
}

class _OnboardingScrState extends State<OnboardingScr> {
  final _controller = PageController();
  bool _onlastpage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.fitHeight)),
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (value) {
                setState(() {
                  _onlastpage = (value == 2);
                });
              },
              children: const [
                OnboardingPage1(),
                OnboardingPage2(),
                OnboardingPage3(),
              ],
            ),
            Container(
                alignment: const Alignment(0, 0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: CustomizableEffect(
                          spacing: 5,
                          dotDecoration: DotDecoration(
                              color: Colors.white38,
                              borderRadius: BorderRadius.circular(5)),
                          activeDotDecoration: DotDecoration(
                              color: Colors.white,
                              height: 20,
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25),
                        ),
                      ),
                      child: Center(
                        child: _onlastpage
                            ? InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                      fontSize: 20),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  _controller.nextPage(
                                      duration:
                                          const Duration(microseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: const Text(
                                  'Tiếp tục',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 20),
                                ),
                              ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
