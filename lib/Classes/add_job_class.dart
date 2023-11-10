class AddJobDto {
  String user;
  String title;
  String position;
  String salary;
  String khuvuctinh;
  String khuvuchuyen;
  String tencty;
  String logocty;
  String image;
  String motacv;
  String yeucaucv;
  AddJobDto(
      {required this.motacv,
      required this.title,
      required this.user,
      required this.yeucaucv,
      required this.position,
      required this.image,
      required this.khuvuchuyen,
      required this.khuvuctinh,
      required this.salary,
      required this.tencty,
      required this.logocty});

  static AddJobDto fromJson(dynamic data) {
    return AddJobDto(
        motacv: data['motacv'],
        yeucaucv: data['yeucaucv'],
        title: data['title'],
        user: data['user'],
        position: data['position'],
        image: data['image'],
        khuvuchuyen: data['khuvuchuyen'],
        khuvuctinh: data['khuvuctinh'],
        salary: data['salary'],
        logocty: data['logocty'],
        tencty: data['tencty']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'user': user,
      'position': position,
      'salary': salary,
      'khuvuctinh': khuvuctinh,
      'khuvuchuyen': khuvuchuyen,
      'tencty': tencty,
      'logocty': logocty,
      'image': image,
      'motacv': motacv,
      'yeucaucv': yeucaucv
    };
  }
}
