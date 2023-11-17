class JobsClass {
  String id;
  String user;
  String title;
  String date;
  String position;
  String salary;
  String khuvuctinh;
  String khuvuchuyen;
  double latitude;
  double longitude;
  String tencty;
  String logocty;
  String image;
  List<String> motacv;
  List<String> yeucaucv;
  JobsClass(
      {required this.motacv,
      required this.id,
      required this.title,
      required this.user,
      required this.yeucaucv,
      required this.date,
      required this.position,
      required this.image,
      required this.khuvuchuyen,
      required this.khuvuctinh,
      required this.latitude,
      required this.longitude,
      required this.salary,
      required this.tencty,
      required this.logocty});

  static JobsClass fromJson(dynamic data) {
    List<dynamic> motacvList = data['motacv'];
    List<String> finalmotacvList = motacvList.map((e) => e.toString()).toList();
    List<dynamic> yeucaucv = data['yeucaucv'];
    List<String> finalyeucaucvList = yeucaucv.map((e) => e.toString()).toList();

    return JobsClass(
        motacv: finalmotacvList,
        yeucaucv: finalyeucaucvList,
        date: data['date'],
        id: data['id'],
        title: data['title'],
        user: data['user'],
        position: data['position'],
        image: data['image'],
        khuvuchuyen: data['khuvuchuyen'],
        khuvuctinh: data['khuvuctinh'],
        latitude: data['latitude'],
        longitude: data['longitude'],
        salary: data['salary'],
        logocty: data['logocty'],
        tencty: data['tencty']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'user': user,
      'date': date,
      'position': position,
      'salary': salary,
      'khuvuctinh': khuvuctinh,
      'khuvuchuyen': khuvuchuyen,
      'latitude': latitude,
      'longitude': longitude,
      'tencty': tencty,
      'logocty': logocty,
      'image': image,
      'motacv': motacv,
      'yeucaucv': yeucaucv
    };
  }
}
