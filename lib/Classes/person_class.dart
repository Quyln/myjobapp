class PersonInfo {
  String image;
  String name;
  String position;
  int money;
  String companyname;

  PersonInfo(
      {required this.companyname,
      required this.image,
      required this.money,
      required this.name,
      required this.position});

  static PersonInfo fromJson(dynamic data) {
    return PersonInfo(
        companyname: data['company'],
        image: data['image'],
        money: data['money'],
        name: data['name'],
        position: data['position']);
  }
}
