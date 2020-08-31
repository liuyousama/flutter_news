import 'package:dio/dio.dart';
import 'package:flutter_news/core/model/error_model.dart';
import 'package:flutter_news/core/network/consts.dart';
import 'package:flutter_news/core/network/ram_cache.dart';
import 'package:flutter_news/core/storage/global_storage.dart';

class LYHttp {
  static LYHttp _instance;

  factory LYHttp() {
    if (_instance == null) {
      _instance = LYHttp._internal();
    }
    return _instance;
  }

  Dio _dio;
  CancelToken cancelToken;

  LYHttp._internal() {
    final options = BaseOptions(
      baseUrl: SERVER_BASE_URL,
      // 请求超时时间10s
      connectTimeout: 10000,
      // 流中两次响应间隔最长时间5s
      receiveTimeout: 5000,
      // 所有请求都会携带的header
      headers: {},
      validateStatus: (code) => code == 200,
      // 默认请求json数据，接受json数据
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    cancelToken = CancelToken();

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options) {
      print("发起请求");
      final userProfile = GlobalStorage.userProfile;
      if (userProfile != null) options.headers["Authorization"] = userProfile.accessToken;
      return options;
    }, onResponse: (res) {
      print("收到响应");
      return res;
    }, onError: (e) {
      print("发生错误: $e");
      return e;
    }));
    // 添加内存缓存interceptor
    _dio.interceptors.add(LYRamCache());
  }

  Future get(String path, {
    Map<String, dynamic> query,
    Options options,
    CancelToken cancelToken,
    bool isRefresh = false,
    bool isList = false,
    bool cacheOpen = true,
    String cacheKey
  }) async {
    try {
      options = options ?? Options();
      options.extra["refresh"] = isRefresh;
      options.extra["list"] = isList;
      options.extra["cache"] = cacheOpen;
      options.extra["cacheKey"] = cacheKey;
      var response = await _dio.get(path,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch(e) {
      throw _createErrorModel(e);
    }
  }

  Future post(String path, {dynamic params, Map<String, dynamic> query,
    Options options, CancelToken cancelToken}) async
  {
    try {
      var response = await _dio.post(path,
        data: params,
        queryParameters: query,
        options: options,
        cancelToken: cancelToken
      );
      return response.data;
    } on DioError catch(e) {
      print(e);
      throw _createErrorModel(e);
    }
  }

  LYErrorModel _createErrorModel(DioError e) {
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return LYErrorModel(NetworkErrorCode, "网络连接超时");
      case DioErrorType.RECEIVE_TIMEOUT:
        return LYErrorModel(NetworkErrorCode, "网络响应超时");
      case DioErrorType.SEND_TIMEOUT:
        return LYErrorModel(NetworkErrorCode, "网络请求超时");
      case DioErrorType.CANCEL:
        return LYErrorModel(OtherErrorCode, "请求取消");
      case DioErrorType.RESPONSE:
        try {
          final code = e.response.statusCode;
          switch (code) {
            case 400:
              return LYErrorModel(UserRequestErrorCode, "错误的请求");
            case 401:
              return LYErrorModel(UserAuthorizeErrorCode, "用户登录信息已过期");
            case 403:
              return LYErrorModel(UserRequestErrorCode, "请求被拒绝执行");
            case 404:
              return LYErrorModel(UserRequestErrorCode, "无法连接至服务器");
            case 500:
              return LYErrorModel(ServerErrorCode, "服务器错误");
            case 502:
              return LYErrorModel(ServerErrorCode, "网关错误");
            case 503:
              return LYErrorModel(ServerErrorCode, "服务器正在开小差");
            default:
              return LYErrorModel(OtherErrorCode, e.response.statusMessage);
          }
        } on Exception catch (_) {
          return LYErrorModel(OtherErrorCode, "未知错误");
        }
        break;
      default:
        return LYErrorModel(OtherErrorCode, "未知错误");
    }
  }
}