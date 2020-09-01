class NewsItemModel {
  NewsItemModel({
    this.thumbnail,
    this.title,
    this.category,
    this.addtime,
    this.author,
    this.url,
    this.id,
  });

  String thumbnail;
  String title;
  String category;
  DateTime addtime;
  String author;
  String url;
  String id;

  factory NewsItemModel.fromJson(Map<String, dynamic> json) => NewsItemModel(
    thumbnail: json["thumbnail"],
    title: json["title"],
    category: json["category"],
    addtime: DateTime.parse(json["addtime"]),
    author: json["author"],
    url: json["url"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "thumbnail": thumbnail,
    "title": title,
    "category": category,
    "addtime": addtime.toIso8601String(),
    "author": author,
    "url": url,
    "id": id,
  };
}