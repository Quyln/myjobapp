import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/login_getuser_provider.dart';
import 'package:provider/provider.dart';

class AppBarNSec extends StatelessWidget {
  const AppBarNSec({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsersProvider>(
      create: (context) {
        return UsersProvider();
      },
      child: Consumer<UsersProvider>(
        builder: (context, value, child) {
          return SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: Colors.white,
            leading: const Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
            ),
            title: const Center(
              child: Text(
                'TIN TỨC',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: Image.network(
                    value.user.avatar,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
