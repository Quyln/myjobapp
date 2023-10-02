import 'package:flutter/material.dart';
import 'package:myjobapp/utils/colors.dart';

class JSecAppBar extends StatelessWidget {
  const JSecAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
          size: 30,
          color: Colors.black,
        ),
      ),
      title: const Text(
        'THỊ TRƯỜNG VIỆC LÀM',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w300, fontSize: 18),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: maunen,
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
