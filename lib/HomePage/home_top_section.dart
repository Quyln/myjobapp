import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.lightBlueAccent,
                backgroundImage: NetworkImage(
                    'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trần Khả Như',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'Quản trị viên',
                    style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.search)
        ],
      ),
    );
  }
}
