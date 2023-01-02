// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:tamplates_app/const/app_colors.dart';
// import 'package:tamplates_app/ui/route/route.dart';
// import 'package:tamplates_app/ui/widgets/app_buttons.dart';
// import 'package:tamplates_app/ui/widgets/text_from_field.dart';

// class ForgotPassword extends StatelessWidget {
//   TextEditingController _emailController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Form(
//           key: _formkey,
//           child: Padding(
//             padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Get.toNamed(signIn);
//                     },
//                     icon:const Icon(Icons.arrow_back,color: AppColors.violetColor,)),
//                 Text(
//                   "Forgot Your Password ?",
//                   style: TextStyle(
//                     fontSize: 36.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.violetColor,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Text(
//                   "Reset Now & Check Your Mail",
//                   style: TextStyle(
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 80.h,
//                 ),
//                 customTextField(
//                   TextInputType.emailAddress,
//                   false,
//                   _emailController,
//                   null,
//                   context,
//                   "Enter Your Email",
//                   (value) {
//                     if (value == null || value.isEmpty) {
//                       return "this field can't be empty";
//                     } else if (!value.contains(
//                       RegExp(r'\@'),
//                     )) {
//                       return "enter a valid email address";
//                     }

//                     return null;
//                   },
//                 ),
//                 VioletButton("Change Password", () async {
//                   if (_formkey.currentState!.validate()) {
//                     try {
//                       await FirebaseAuth.instance
//                           .sendPasswordResetEmail(email: _emailController.text)
//                           .whenComplete(() {
//                         Fluttertoast.showToast(
//                             msg: "Check Your Mail", timeInSecForIosWeb: 3);
//                         Get.toNamed(signIn);
//                       });
//                     } catch (e) {
//                       Fluttertoast.showToast(msg: e.toString());
//                     }
//                   }
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
