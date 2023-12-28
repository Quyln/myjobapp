class OneUserInfo {
  String id;
  String avatar;
  String fullname;
  String companyname;
  String? longitude;
  String? latitude;

  OneUserInfo(
      {required this.id,
      required this.avatar,
      required this.companyname,
      this.longitude,
      this.latitude,
      required this.fullname});

  static OneUserInfo fromJson(Map<String, dynamic> data) {
    return OneUserInfo(
      id: data['id'],
      fullname: data['fullname'],
      avatar: data['avatar'],
      companyname: data['companyname'],
      longitude: data['longitude'],
      latitude: data['latitude'],
    );
  }
}
