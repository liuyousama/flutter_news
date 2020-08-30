import 'package:flutter_news/core/utils/screen_util.dart';

extension ScreenAdaptDouble on double {
  double get lyWidth => LYScreenUtil.widthAdapt(this);
  double get lyHeight => LYScreenUtil.heightAdapt(this);
  double get lyFont => LYScreenUtil.fontAdapt(this);
}