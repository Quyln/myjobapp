import 'package:flutter/material.dart';

class AppBarNSec extends StatelessWidget {
  const AppBarNSec({super.key});

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(
                'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
          ),
        ),
      ],
    );
  }
}
