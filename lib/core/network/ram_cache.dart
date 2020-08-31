import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_news/core/network/consts.dart';

/// 缓存对象，用来存储一次请求的响应内容
class LYCacheObject {
  Response response;
  int time;

  LYCacheObject(this.response)
    : time = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(Object other) {
    return this.hashCode == other.hashCode;
  }

  @override
  int get hashCode{
    return response.realUri.hashCode;
  }

}
/// 内存缓存处理器，主要在请求发出之前以及响应到达时做出响应处理，缓存请求内容
class LYRamCache implements Interceptor{
  var _cache = LinkedHashMap<String, LYCacheObject>();
  /// 发生错误：不进行任何缓存处理
  @override
  Future onError(DioError err) async {
    return err;
  }

  @override
  Future onRequest(RequestOptions options) async {
    // 1. 全局缓存控制
    if (!RAM_CACHE_ENABLED) return options;
    // 2. 只有Get请求方法才可以被缓存，其他方法缓存无意义
    final isGet = options.method.toLowerCase() == "get";
    if (!isGet) return options;

    final isRefresh = options.extra["refresh"] == true;
    final isList = options.extra["list"] == true;
    // 3. 如果是一个刷新请求，且并非一个列表请求，则删除其缓存
    if (isRefresh && !isList) {
      _cache.remove(options.uri.toString());
      return options;
    // 4. 如果是一个刷新请求，且是一个列表请求，则删除掉与这个列表请求相关的所有缓存
    } else if (isRefresh && isList) {
      _cache.removeWhere((key, value) => key.contains(options.path.toString()));
    }
    // 5. 局部缓存控制
    final isCache = options.extra["cache"] == true;
    if (!isCache) return options;
    // 6. 查找缓存，如果找到有效缓存，直接使用缓存的响应，不再发起网络请求
    final cacheKey = options.extra["cacheKey"] ?? options.uri.toString();
    final cacheObj = _cache[cacheKey];
    if (cacheObj == null) return options;
    // 判断缓存是否过期
    if (cacheObj.time+RAM_CACHE_EXPIRE_TIME*1000 > DateTime.now().millisecondsSinceEpoch) {
      return cacheObj.response;
    } else {
      _cache.remove(cacheKey);
      return options;
    }
  }

  @override
  Future onResponse(Response response) async {
    // 1. 全局缓存控制
    if (!RAM_CACHE_ENABLED) return response;
    // 2. 局部缓存控制
    final options = response.request;
    final isCache = options.extra["cache"] == true;
    if (!isCache) return response;
    // 3. 只有get请求方法才能被缓存
    final isGet = options.method.toLowerCase() == "get";
    if (!isGet) return response;
    // 4. 如果缓存已满，清除第一个
    if (_cache.length >= RAM_CACHE_MAX_COUNT) {
      _cache.remove(_cache.keys.first);
    }
    // 5. 设置缓存
    final cacheKey = options.extra["cacheKey"] ?? options.uri.toString();
    _cache[cacheKey] = LYCacheObject(response);
  }
}