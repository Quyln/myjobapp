class CreateUserDto {
  String id;
  String password;
  String fullname;
  String position;
  String lastjob;
  String avatar;
  String phone;
  String savejobs;
  String appliedjobs;
  String postedjobs;
  String email;
  String companyname;
  String companytax;

  CreateUserDto({
    required this.id,
    required this.avatar,
    required this.fullname,
    required this.lastjob,
    required this.password,
    required this.phone,
    required this.email,
    required this.position,
    required this.savejobs,
    required this.appliedjobs,
    required this.postedjobs,
    required this.companyname,
    required this.companytax,
  });
  static CreateUserDto fromJson(dynamic data) {
    return CreateUserDto(
        id: data['id'],
        password: data['password'],
        fullname: data['fullname'],
        phone: data['phone'],
        lastjob: data['lastjob'],
        email: data['email'],
        savejobs: data['savejobs'],
        appliedjobs: data['appliedjobs'],
        postedjobs: data['postedjobs'],
        avatar: data['avatar'],
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
      'email': email,
      'avatar': avatar,
      'position': position,
      'savejobs': savejobs,
      'appliedjobs': appliedjobs,
      'postedjobs': postedjobs,
      'companyname': companyname,
      'companytax': companytax,
    };
  }
}
