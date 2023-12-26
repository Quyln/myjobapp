class OneUserInfo {
  String id;
  String avatar;
  String fullname;
  String companyname;

  OneUserInfo(
      {required this.id,
      required this.avatar,
      required this.companyname,
      required this.fullname});

  static OneUserInfo fromJson(Map<String, dynamic> data) {
    return OneUserInfo(
      id: data['id'],
      fullname: data['fullname'],
      avatar: data['avatar'],
      companyname: data['companyname'],
    );
  }
}
