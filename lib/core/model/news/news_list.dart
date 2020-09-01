import 'package:flutter_news/core/model/news/news_item.dart';

class NewsListModel {
  NewsListModel({
    this.counts,
    this.pagesize,
    this.pages,
    this.page,
    this.items,
  });

  int counts;
  int pagesize;
  int pages;
  int page;
  List<NewsItemModel> items;

  factory NewsListModel.fromJson(Map<String, dynamic> json) => NewsListModel(
    counts: json["counts"],
    pagesize: json["pagesize"],
    pages: json["pages"],
    page: json["page"],
    items: List<NewsItemModel>.from(json["items"].map((x) => NewsItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "counts": counts,
    "pagesize": pagesize,
    "pages": pages,
    "page": page,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}