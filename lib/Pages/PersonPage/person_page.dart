import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/PersonPage/person_creator_page.dart';
import 'package:myjobapp/Pages/PersonPage/person_member_page.dart';
import 'package:myjobapp/Provider/get_jobs_byid_provider.dart';
import 'package:myjobapp/Provider/login_getuser_provider.dart';
import 'package:provider/provider.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
      ],
      child: Consumer<GetUserProvider>(
        builder: (context, value, child) {
          if (value.user.position == 'Thành viên') {
            return PersonPMember(
              userData: value.user,
            );
          } else {
            return PersonPCreator(
              userData: value.user,
            );
          }
        },
      ),
    );
  }
}
