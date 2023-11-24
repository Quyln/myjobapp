import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/Welcome_Login_Pages/OnboardingScreen/onboarding_screen.dart';
import 'package:provider/provider.dart';

import 'Provider/Home_list_provider.dart';
import 'Provider/Job_list_provider.dart';
import 'Provider/get_jobs_byid_provider.dart';
import 'Provider/login_getuser_provider.dart';
import 'Provider/news_list_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<GetUserProvider>(
      create: (context) {
        return GetUserProvider();
      },
    ),
    ChangeNotifierProvider<GetSaveJobsByID>(
      create: (context) {
        return GetSaveJobsByID();
      },
    ),
    ChangeNotifierProvider<GetAppliedJobsByID>(
      create: (context) {
        return GetAppliedJobsByID();
      },
    ),
    ChangeNotifierProvider<GetPostedJobsByID>(
      create: (context) {
        return GetPostedJobsByID();
      },
    ),
    ChangeNotifierProvider<NewsProvider>(
      create: (context) {
        return NewsProvider();
      },
    ),
    ChangeNotifierProvider<JobsProvider>(
      create: (context) {
        return JobsProvider();
      },
    ),
    ChangeNotifierProvider<HTinnoibatPro>(
      create: (context) {
        return HTinnoibatPro();
      },
    ),
    ChangeNotifierProvider<HviecmoinhatPro>(
      create: (context) {
        return HviecmoinhatPro();
      },
    )
  ], child: const MyJob()));
}

class MyJob extends StatelessWidget {
  const MyJob({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScr(),
    );
  }
}
