import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class SU {
  // 屏幕宽度，用法作 1 * SU.screenWidth
  static double get screenWidth => 1.sw;
  // 屏幕高度
  static double get screenHeight => 1.sh;

  // 屏幕状态栏高度
  static get statusBarHeight => ScreenUtil().statusBarHeight;
  // 屏幕像素密度
  static get pixelRatio => ScreenUtil().pixelRatio;

  static get bottomInsetHeight => _bottomInsetHeight;
  static double _bottomInsetHeight = 0;
  static setBottomInsetHeight(double height) {
    if (height == 0) return;
    if (_bottomInsetHeight == 0) {
      _bottomInsetHeight = height;
    } else {
      return;
    }
  }

  // 底部导航栏高度
  static get bottomBarHeight => ScreenUtil().bottomBarHeight;

  static get navBarHeight => 50;

  // 屏幕宽度缩放比例
  // static get scaleWidth => ScreenUtil().scaleWidth;
  // 屏幕高度缩放比例
  // static get scaleHeight => ScreenUtil().scaleHeight;

  // 顶部padding一个状态栏的高度
  static get paddingTopStatusBar => EdgeInsets.only(top: statusBarHeight);

  // 屏幕方向
  static get orientation => ScreenUtil().orientation;

  // 字体缩放比例
  static get textScaleFactor => ScreenUtil().textScaleFactor;

  static get appBarDefaultHeight => 43.0;

  static get appLeftRightMargin => const EdgeInsets.symmetric(horizontal: 15);

  static get commonBorderRadius => 9.0;
  static get alertBorderRadius => 21.8;
  static get cardBorderRadius => 31.8;
}
