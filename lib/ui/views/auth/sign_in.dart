import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:tamplates_app/business_logics/auth_helper.dart';
import 'package:tamplates_app/const/app_colors.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/views/auth/user_screen.dart';
import 'package:tamplates_app/ui/widgets/app_buttons.dart';
import 'package:tamplates_app/ui/widgets/text_from_field.dart';
import '../bottom_nav_pages/home/home_screen.dart';

class SignIn extends StatelessWidget {
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // final _formkey = GlobalKey<FormState>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login\nTo Your Account",
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.violetColor,
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
              Lottie.asset('assets/files/login.json',height: 300),
              // customTextField(
              //   TextInputType.emailAddress,
              //   false,
              //   _emailController,
              //   null,
              //   context,
              //   "Enter Your Email",
              //   (value) {
              //     if (value == null || value.isEmpty) {
              //       return "this field can't be empty";
              //     } else if (!value.contains(
              //       RegExp(r'\@'),
              //     )) {
              //       return "enter a valid email address";
              //     }
              //     return null;
              //   },
              // ),
              // customTextField(
              //   TextInputType.text,
              //   true,
              //   _passwordController,
              //   null,
              //   context,
              //   "Enter Your Password",
              //   (value) {
              //     if (value == null || value.isEmpty) {
              //       return "this field can't be empty";
              //     } else if (value.length < 6) {
              //       return "password must be 6 characters";
              //     }
              //     return null;
              //   },
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: InkWell(
              //     onTap: () {
              //       Get.toNamed(resetPass);
              //     },
              //     child: Text(
              //       "Forgot Password ?",
              //       style: TextStyle(
              //         fontSize: 16.sp,
              //         fontWeight: FontWeight.w500,
              //         color: AppColors.violetColor,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 40.h,
              // ),
              // VioletButton("Login", () async {
              //   if (_formkey.currentState!.validate()) {
              //     var box = GetStorage();
              //     box.write("check", true);
              //     Auth().login(_emailController.text,
              //         _passwordController.text, context);
              //   }
              // }),
              // SizedBox(
              //   height: 10.h,
              // ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Text(
              //     "--OR--",
              //     style: TextStyle(
              //       fontSize: 16.sp,
              //       fontWeight: FontWeight.w300,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 10.h,
              // ),
              // RichText(
              //   text: TextSpan(
              //     text: "Don’t have registered yet?  ",
              //     style: TextStyle(
              //       fontSize: 18.sp,
              //       fontWeight: FontWeight.w300,
              //       color: Colors.black,
              //     ),
              //     children: [
              //       TextSpan(
              //         text: "Sign Up",
              //         style: TextStyle(
              //           fontSize: 18.sp,
              //           fontWeight: FontWeight.w600,
              //           color: AppColors.violetColor,
              //         ),
              //         recognizer: TapGestureRecognizer()
              //           ..onTap = () => Get.toNamed(signUp),
              //       )
              //     ],
              //   ),
              // ),

              VioletButton("SignIn with Google", () {
                var box = GetStorage();
                box.write("check", true);
               Auth().signInWithGoogle(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
