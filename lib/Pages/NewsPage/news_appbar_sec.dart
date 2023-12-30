import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:flutter/material.dart';
import 'package:myjobapp/Provider/login_get_update_user_provider.dart';
import 'package:provider/provider.dart';

class AppBarNSec extends StatelessWidget {
  const AppBarNSec({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GetUserProvider>(
      create: (context) {
        return GetUserProvider();
      },
      child: Consumer<GetUserProvider>(
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
                padding: const EdgeInsets.only(right: 15, top: 10, bottom: 5),
                child: ClipOval(
                  child: SizedBox(
                    width: 40,
                    height: 30,
                    child: CachedMemoryImage(
                      uniqueKey: 'app://image/avatar',
                      base64: value.user.avatar,
                      fit: BoxFit.cover,
                    ),
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
