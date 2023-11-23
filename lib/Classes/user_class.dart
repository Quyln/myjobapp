class User {
  String id;
  String password;
  String fullname;
  String position;
  String lastjob;
  String avatar;
  String phone;
  String? savejobs;
  String? appliedjobs;
  String? postedjobs;
  int token;
  String companyname;
  String companytax;

  User({
    required this.id,
    required this.avatar,
    required this.fullname,
    required this.lastjob,
    required this.password,
    required this.phone,
    required this.position,
    required this.savejobs,
    required this.appliedjobs,
    required this.postedjobs,
    required this.token,
    required this.companyname,
    required this.companytax,
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
        savejobs: data['savejobs'],
        appliedjobs: data['appliedjobs'],
        postedjobs: data['postedjobs'],
        position: data['position'],
        companyname: data['companyname'],
        companytax: data['companytax']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'fullname': fullname,
      'phone': phone,
      'lastjob': lastjob,
      'token': token,
      'avatar': avatar,
      'savejobs': savejobs,
      'appliedjobs': appliedjobs,
      'postedjobs': postedjobs,
      'position': position,
      'companyname': companyname,
      'companytax': companytax,
    };
  }
}
