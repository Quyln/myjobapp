class UserForSearch {
  String id;
  String avatar;
  String fullname;
  String companyname;
  String? longitude;
  String? latitude;
  double? distance;

  UserForSearch(
      {required this.id,
      required this.avatar,
      required this.companyname,
      this.longitude,
      this.latitude,
      this.distance,
      required this.fullname});

  static UserForSearch fromJson(dynamic data) {
    return UserForSearch(
      id: data['id'],
      fullname: data['fullname'],
      avatar: data['avatar'],
      companyname: data['companyname'],
      longitude: data['longitude'],
      latitude: data['latitude'],
    );
  }
}
