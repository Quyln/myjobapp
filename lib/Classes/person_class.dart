class User {
  String id;
  String password;
  String fullname;
  String position;
  String lastjob;
  String avatar;
  String phone;
  int token;

  User({
    required this.id,
    required this.avatar,
    required this.fullname,
    required this.lastjob,
    required this.password,
    required this.phone,
    required this.position,
    required this.token,
  });
  static User fromJson(dynamic data) {
    return User(
        id: data['id'],
        password: data['password'],
        fullname: data['fullname'],
        phone: data['phone'],
        lastjob: data['lastjob'],
        token: data['token'],
        avatar: data['avatar'],
        position: data['position']);
  }
}
