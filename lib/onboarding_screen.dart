import 'package:flutter/material.dart';
import 'package:myjobapp/OnboardingPages/page1.dart';
import 'package:myjobapp/OnboardingPages/page2.dart';
import 'package:myjobapp/OnboardingPages/page3.dart';
import 'package:myjobapp/login_sceen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      body: Stack(
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
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(5)),
                        activeDotDecoration: DotDecoration(
                            color: Colors.black,
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
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                _controller.nextPage(
                                    duration: const Duration(microseconds: 500),
                                    curve: Curves.easeIn);
                              },
                              child: const Text(
                                'Tiếp tục',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
