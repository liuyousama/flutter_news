class CategoryModel {
  CategoryModel({
    this.code,
    this.title,
  });

  String code;
  String title;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    code: json["code"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "title": title,
  };
}
