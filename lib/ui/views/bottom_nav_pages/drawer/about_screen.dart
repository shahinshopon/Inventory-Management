
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tamplates_app/const/app_strings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppString.bookImage,
                  height: 200.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  AppString.myPrepper,
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  AppString.builtPhoneYourApp,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(onPressed: ()=>Get.back(), child: Text(AppString.ok))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
