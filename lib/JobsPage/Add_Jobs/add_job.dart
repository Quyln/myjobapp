import 'package:flutter/material.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _titlecontroller = TextEditingController();
  final _positioncontroller = TextEditingController();
  final _namecontroller = TextEditingController();

  final _contentcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          'TẠO BÀI ĐĂNG',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.network(
                  'https://www.premadegraphics.com/img_1/23/Female-Avatar-2.png'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    controller: _titlecontroller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                        hintText: 'Tiêu đề', border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    controller: _positioncontroller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                        hintText: 'Vị trí tuyển dụng',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    readOnly: true,
                    controller: _namecontroller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                        hintText: 'Công ty TNHH Kim Oanh',
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    maxLines: 19,
                    maxLength: 400,
                    controller: _contentcontroller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                        hintText: 'Nội dung', border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.purple),
                  child: const Center(
                    child: Text(
                      'ĐĂNG BÀI',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
