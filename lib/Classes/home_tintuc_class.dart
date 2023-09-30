class TinTucClass {
  String link;
  String image;
  String title;
  TinTucClass({
    required this.link,
    required this.image,
    required this.title,
  });

  static TinTucClass fromJson(dynamic data) {
    return TinTucClass(
        image: data['image'], title: data['title'], link: data['link']);
  }
}
