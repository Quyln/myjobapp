import 'package:flutter/material.dart';

import '../../../Classes/component/more_menu_class.dart';

// ignore: must_be_immutable
class BuildLongPressMenu extends StatelessWidget {
  BuildLongPressMenu({super.key});

  List<ItemModel> menuItems = [
    ItemModel('Nhắn tin', Icons.send),
    ItemModel('Trả lời', Icons.format_quote),
    ItemModel('Tìm kiếm', Icons.search),
  ];
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 55,
        width: 200,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: menuItems
              .map((item) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        item.icon,
                        size: 20,
                        color: Colors.white,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        child: Text(
                          item.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
