class UserForSearch {
  String id;
  String avatar;
  String fullname;
  String companyname;

  UserForSearch(
      {required this.id,
      required this.avatar,
      required this.companyname,
      required this.fullname});

  static UserForSearch fromJson(dynamic data) {
    return UserForSearch(
      id: data['id'],
      fullname: data['fullname'],
      avatar: data['avatar'],
      companyname: data['companyname'],
    );
  }
}
