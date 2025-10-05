import 'package:flutter_screenutil/flutter_screenutil.dart';

// static double padX = 16.w; (calculated once)
// static double get padX => 16.w; (recalculated on rebuild)
class MyDimension {

  static double get padAll => 10.r;
  static double get padX => 10.w;
  static double get padY => 10.h;
  static double get boxRadius => 8.r;
  static double get buttonHeight => 45.h;
  static double get imageDefaultX => 90.w;
  static double get imageDefaultY => 92.h;
  static double get padL => 20.w;
  static double get padR => 20.w;
  static double get padT => 20.h;
  static double get padB => 20.h;
  static double get fieldHeight => 44.h;
  static double get boarderRadius => 8.w;

  // margin/space
  static double get spaceL => 20.w;
  static double get spaceR => 20.w;
  static double get spaceT => 20.h;
  static double get spaceB => 20.h;
  static double get spaceX => 8.w;
  static double get spaceY => 8.h;
  static double get spaceAll => 10.r;

  // All Font Sizes //
  static double get fontDoubleXL => 24.sp;
  static double get fontXL       => 18.sp;
  static double get fontL        => 16.sp;
  static double get fontM        => 14.sp;
  static double get fontSS       => 12.sp;
  static double get fontS        => 10.sp;
}
