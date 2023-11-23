import 'package:flutter/material.dart';
import 'package:myjobapp/Pages/PersonPage/person_creator_page.dart';
import 'package:myjobapp/Pages/PersonPage/person_member_page.dart';
import 'package:myjobapp/Provider/get_jobs_byid.dart';
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
        // Thêm các Provider khác ở đây (nếu có)
        ChangeNotifierProvider<GetJobsByID>(
          create: (context) {
            return GetJobsByID();
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
