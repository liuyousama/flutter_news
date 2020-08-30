
import 'package:flutter_news/core/utils/screen_util.dart';

extension ScreenAdapt on int {
  double get lyWidth => LYScreenUtil.widthAdapt(this.toDouble());
  double get lyHeight => LYScreenUtil.heightAdapt(this.toDouble());
  double get lyFont => LYScreenUtil.fontAdapt(this.toDouble());
}