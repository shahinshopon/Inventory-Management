import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static TextStyle myTextStyle = TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w300, color: Colors.black);
  static TextStyle titleStyle = TextStyle(fontSize: 20.sp);
  static BoxDecoration borderDecoration = BoxDecoration(
    border: Border.all(
      color: Colors.black54,
    ),
    borderRadius: BorderRadius.circular(10.r),
  );
  static EdgeInsets kRegularPadding = const EdgeInsets.all(5);
  static SizedBox verticallySizedbox = SizedBox(
    height: 10.h,
  );
  static SizedBox horizontallySizedbox = SizedBox(
    width: 15.w,
  );
}
