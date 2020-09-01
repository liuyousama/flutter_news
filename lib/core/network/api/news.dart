import 'package:flutter_news/core/model/news/category.dart';
import 'package:flutter_news/core/model/news/news_item.dart';
import 'package:flutter_news/core/model/news/news_list.dart';
import 'package:flutter_news/core/network/http.dart';

class NewsApi {
  /// 分类列表
  static Future<List<CategoryModel>> getCategories() async {
    final data = await LYHttp().get("/categories");
    return (data as List).map((e) => CategoryModel.fromJson(e)).toList();
  }
  /// 分类列表
  static Future<List<CategoryModel>> getChannels() async {
    final data = await LYHttp().get("/channels");
    return (data as List).map((e) => CategoryModel.fromJson(e)).toList();
  }
  /// 标签列表
  static Future<List<String>> getTags() async {
    final data = await LYHttp().get("/tags");
    return data as List<String>;
  }
  /// 推荐新闻
  static Future<NewsItemModel> getRecommend({
    String categoryCode,
    String tag,
    String channelCode,
    String keyword}) async {
    var query = Map<String, dynamic>();
    if (categoryCode != null) query["categoryCode"] = categoryCode;
    if (tag != null) query["tag"] = tag;
    if (channelCode != null) query["channelCode"] = channelCode;
    if (keyword != null) query["keyword"] = keyword;
    final data = await LYHttp().get("/news/recommend", query: query);
    return NewsItemModel.fromJson(data);
  }
  /// 新闻列表
  static Future<NewsListModel> getNewsList() async {
    final data = await LYHttp().get("/news");
    return NewsListModel.fromJson(data);
  }
}