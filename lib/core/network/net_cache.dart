import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_news/core/network/consts.dart';
import 'package:flutter_news/core/storage/preference.dart';

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
/// 缓存处理器，主要在请求发出之前以及响应到达时做出响应处理，缓存请求内容
/// 该类需要使用到请求的上下文信息，它们分别是：
/// "cacheKey":  用户对该请求指定的缓存键，如果没有指定，则会使用默认值（uri）
/// "refresh":   标识该请求是否为刷新请求，如果是刷新请求则会清除之前的缓存
/// "list":      标识该请求是否为列表请求，列表请求在刷新时不仅会清除自身的缓存，还会清除同属于一个列表的其他请求的缓存
/// "cacheRam":  标识该请求是否开启内存缓存
/// "cacheDisk": 标识该请求是否开启磁盘缓存
class LYNetCache implements Interceptor{
  var _cache = LinkedHashMap<String, LYCacheObject>();
  /// 发生错误：不进行任何缓存处理
  @override
  Future onError(DioError err) async {
    return err;
  }

  String _diskCacheKey(RequestOptions options) {
    return options.extra["cacheKey"]
        ?? "com.liuyousama.news.localcache.${options.uri.toString()}";
  }
  String _ramCacheKey(RequestOptions options) {
    return options.extra["cacheKey"] ?? options.uri.toString();
  }

  @override
  Future onRequest(RequestOptions options) async {
    // 1. 全局缓存控制
    if (!NET_CACHE_ENABLED) return options;
    // 2. 只有Get请求方法才可以被缓存，其他方法缓存无意义
    final isGet = options.method.toLowerCase() == "get";
    if (!isGet) return options;

    final isRefresh = options.extra["refresh"] == true;
    final isList = options.extra["list"] == true;
    final diskCacheKey = _diskCacheKey(options);
    final ramCacheKey = _ramCacheKey(options);
    // 3. 只要是刷新请求，就移除磁盘缓存
    if (isRefresh) LYPreference.remove(diskCacheKey);
    // 4. 如果是一个刷新请求，且并非一个列表请求，则删除其缓存
    if (isRefresh && !isList) {
      _cache.remove(ramCacheKey);
      return options;
    // 5. 如果是一个刷新请求，且是一个列表请求，则删除掉与这个列表请求相关的所有缓存
    } else if (isRefresh && isList) {
      _cache.removeWhere((key, value) => key.contains(options.path.toString()));
      return options;
    }
    // 6. 内存缓存局部控制
    final isRamCache = options.extra["cacheRam"] == true;
    if (isRamCache) {
      // 7. 查找缓存，如果找到有效缓存，直接使用缓存的响应，不再发起网络请求，若发现缓存已经过期，则删除
      final cacheObj = _cache[ramCacheKey];
      if (cacheObj == null) return options;
      // 判断缓存是否过期
      if (cacheObj.time + RAM_CACHE_EXPIRE_TIME * 1000 > DateTime.now().millisecondsSinceEpoch) {
        assert((){
          print("查找到内存缓存，缓存键：$ramCacheKey");
          return true;
        }());
        return cacheObj.response;
      } else {
        _cache.remove(ramCacheKey);
      }
    }
    // 8. 磁盘缓存局部控制。如果内存缓存未命中，再来查找本地缓存，内存缓存的优先级比本地缓存高
    final isDiskCache = options.extra["cacheDisk"] == true;
    if (isDiskCache) {
      // 9. 如果查找到就直接返回本地磁盘中存储的数据
      final diskData = LYPreference.getJson(diskCacheKey);
      if (diskData != null) {
        // DEBUG
        assert((){
          print("查找到磁盘缓存，缓存键：$diskCacheKey");
          return true;
        }());
        return Response(statusCode: 200, data: diskData);
      }
    }

    return options;
  }

  @override
  Future onResponse(Response response) async {
    // 1. 全局缓存控制
    if (!NET_CACHE_ENABLED) return response;
    // 2. 只有get请求方法才能被缓存
    final options = response.request;
    final isGet = options.method.toLowerCase() == "get";
    if (!isGet) return response;
    // 3. 内存缓存局部控制
    final isRamCache = options.extra["cacheRam"] == true;
    if (isRamCache) {
      // 4. 如果内存缓存已满，清除第一个
      if (_cache.length >= RAM_CACHE_MAX_COUNT) {
        _cache.remove(_cache.keys.first);
      }
      // 5. 设置内存缓存
      final ramCacheKey = _ramCacheKey(options);
      // DEBUG
      assert((){
        print("设置磁盘缓存，缓存键：$ramCacheKey");
        return true;
      }());
      _cache[ramCacheKey] = LYCacheObject(response);
    }
    // 6. 磁盘缓存局部控制
    final isDiskCache = options.extra["cacheDisk"] == true;
    if (isDiskCache) {
      // 7. 设置磁盘缓存
      final diskCacheKey = _diskCacheKey(options);
      // DEBUG
      assert((){
        print("设置磁盘缓存，缓存键：$diskCacheKey");
        return true;
      }());
      LYPreference.setJson(diskCacheKey, response.data);
    }

    return response;
  }
}