class JobsClass {
  String id;
  String date;
  String position;
  String salary;
  String khuvuctinh;
  String khuvuchuyen;
  String tencty;
  String logocty;
  String image;
  List<String> motacv;
  List<String> yeucaucv;
  JobsClass(
      {required this.motacv,
      required this.id,
      required this.yeucaucv,
      required this.date,
      required this.position,
      required this.image,
      required this.khuvuchuyen,
      required this.khuvuctinh,
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
        position: data['position'],
        image: data['image'],
        khuvuchuyen: data['khuvuchuyen'],
        khuvuctinh: data['khuvuctinh'],
        salary: data['salary'],
        logocty: data['logocty'],
        tencty: data['tencty']);
  }
}
