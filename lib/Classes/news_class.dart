class TinTucClass {
  String link;
  String image;
  String title;
  String author;

  TinTucClass({
    required this.link,
    required this.image,
    required this.title,
    required this.author,
  });

  static TinTucClass fromJson(dynamic data) {
    return TinTucClass(
        image: data['image'],
        title: data['title'],
        link: data['link'],
        author: data['author']);
  }

  static Map<String, dynamic> toJson(TinTucClass tintuc) {
    return {
      'image': tintuc.image,
      'title': tintuc.title,
      'link': tintuc.link,
      'author': tintuc.author
    };
  }
}
