class UsersForSearch {
  String id;
  String avatar;
  String fullname;
  String companyname;
  String phone;

  UsersForSearch(
      {required this.id,
      required this.avatar,
      required this.companyname,
      required this.phone,
      required this.fullname});

  static UsersForSearch fromJson(dynamic data) {
    return UsersForSearch(
      id: data['id'],
      fullname: data['fullname'],
      avatar: data['avatar'],
      companyname: data['companyname'],
      phone: data['phone'],
    );
  }
}