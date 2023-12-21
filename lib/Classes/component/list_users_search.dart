class UsersForSearch {
  String id;
  String avatar;
  String fullname;
  String companyname;

  UsersForSearch(
      {required this.id,
      required this.avatar,
      required this.companyname,
      required this.fullname});

  static UsersForSearch fromJson(dynamic data) {
    return UsersForSearch(
      id: data['id'],
      fullname: data['fullname'],
      avatar: data['avatar'],
      companyname: data['companyname'],
    );
  }
}
