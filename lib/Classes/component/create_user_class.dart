class CreateUserDto {
  String id;
  String password;
  String fullname;
  String position;
  String lastjob;
  String avatar;
  String phone;
  String email;
  String token;
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
    required this.token,
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
        token: data['token'],
        email: data['email'],
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
      'token': token,
      'emmail': email,
      'avatar': avatar,
      'position': position,
      'companyname': companyname,
      'companytax': companytax,
    };
  }
}
