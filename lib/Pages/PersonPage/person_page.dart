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
    return Consumer<GetPostedJobsByID>(
      builder: (context, value, child) {
        return Consumer<GetUserProvider>(
          builder: (context, uservalue, child) {
            value.getIdPostedJobs(uservalue.user.id);
            uservalue.getPreGetUser();
            if (uservalue.user.position == 'Thành viên') {
              return PersonPMember(
                userData: uservalue.user,
              );
            } else {
              return PersonPCreator(
                userData: uservalue.user,
              );
            }
          },
        );
      },
    );
  }
}
