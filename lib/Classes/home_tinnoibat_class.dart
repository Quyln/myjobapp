class TinNoiBatHomeClass {
  String link;
  String image;
  String title;
  TinNoiBatHomeClass({
    required this.link,
    required this.image,
    required this.title,
  });

  static TinNoiBatHomeClass fromJson(dynamic data) {
    return TinNoiBatHomeClass(
        image: data['image'], title: data['title'], link: data['link']);
  }
}
