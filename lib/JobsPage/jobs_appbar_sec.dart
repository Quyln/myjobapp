import 'package:flutter/material.dart';

class JSecAppBar extends StatelessWidget {
  const JSecAppBar({super.key});

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
      title: const Text(
        'Tin tức',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: const Color.fromRGBO(220, 223, 229, 1),
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.lightBlueAccent,
            backgroundImage: NetworkImage(
                'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
          ),
        ),
      ],
    );
  }
}
