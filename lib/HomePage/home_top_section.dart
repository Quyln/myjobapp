import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
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
          Row(
            children: [
              const Text(
                '123',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                    fontSize: 20),
              ),
              Image.network(
                'https://th.bing.com/th/id/R.8e15a553c79945c426b3c80bd90f53b6?rik=xEtinSHRUR0Lyg&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2fd%2fd6%2fGold_coin_icon.png&ehk=TPjFkVPmWqsKBkvQ60u9VfBVF%2fVfwjQcMsd%2fHaA6rrk%3d&risl=&pid=ImgRaw&r=0',
                width: 30,
                height: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
