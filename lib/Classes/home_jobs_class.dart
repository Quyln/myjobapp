class JobsClass {
  String date;
  String position;
  String salary;
  String khuvuctinh;
  String khuvuchuyen;
  String title;
  String image;
  List<dynamic> content;

  JobsClass(
      {required this.content,
      required this.date,
      required this.position,
      required this.image,
      required this.khuvuchuyen,
      required this.khuvuctinh,
      required this.salary,
      required this.title});

  static JobsClass fromJson(dynamic data) {
    return JobsClass(
        content: data['content'],
        date: data['date'],
        position: data['position'],
        image: data['image'],
        khuvuchuyen: data['khuvuchuyen'],
        khuvuctinh: data['khuvuctinh'],
        salary: data['salary'],
        title: data['title']);
  }
}
