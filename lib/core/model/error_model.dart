
class LYErrorModel implements Exception {
  int code;
  String message;

  LYErrorModel(this.code, this.message);

  @override
  String toString() {
    return "错误码$code：$message";
  }
}

const UserAuthorizeErrorCode = -1;
const UserRequestErrorCode = -2;
const ServerErrorCode = -3;
const NetworkErrorCode = -4;
const OtherErrorCode = -5;