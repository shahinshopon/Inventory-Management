// // ignore_for_file: must_be_immutable, use_key_in_widget_constructors
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:tamplates_app/business_logics/auth_helper.dart';
// import 'package:tamplates_app/const/app_colors.dart';
// import 'package:tamplates_app/ui/route/route.dart';
// import 'package:tamplates_app/ui/widgets/app_buttons.dart';
// import 'package:tamplates_app/ui/widgets/text_from_field.dart';

// class SignUp extends StatelessWidget {
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   final _formkey = GlobalKey<FormState>();
//   Future _exitDialog(context) {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text("Are u sure to close this app?"),
//             content: Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () => Get.back(),
//                   child: const Text("No"),
//                 ),
//                 SizedBox(
//                   width: 20.w,
//                 ),
//                 ElevatedButton(
//                   onPressed: () => SystemNavigator.pop(),
//                   child: const Text("Yes"),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop: () {
//           _exitDialog(context);
//           return Future.value(false);
//         },
//         child: Scaffold(
//           body: Padding(
//             padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 80.h),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Form(
//                 key: _formkey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           _exitDialog(context);
//                         },
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           size: 30,
//                           color: AppColors.violetColor,
//                         )),
//                     Text(
//                       "Create\nYour Account",
//                       style: TextStyle(
//                         fontSize: 36.sp,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.violetColor,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12.h,
//                     ),
//                     Text(
//                       "Create your account and start your journey......",
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 80.h,
//                     ),
//                     customTextField(
//                       TextInputType.emailAddress,
//                       false,
//                       _emailController,
//                       null,
//                       context,
//                       "Enter Your Email",
//                       (value) {
//                         if (value == null || value.isEmpty) {
//                           return "this field can't be empty";
//                         } else if (!value.contains(
//                           RegExp(r'\@'),
//                         )) {
//                           return "enter a valid email address";
//                         }

//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     customTextField(
//                       TextInputType.text,
//                       true,
//                       _passwordController,
//                       null,
//                       context,
//                       "Enter Your Password",
//                       (value) {
//                         if (value == null || value.isEmpty) {
//                           return "this field can't be empty";
//                         } else if (value.length < 5) {
//                           return "password must be 6 characters";
//                         }

//                         return null;
//                       },
//                     ),
//                     SizedBox(
//                       height: 40.h,
//                     ),
//                     VioletButton("Create Account", () {
//                       if (_formkey.currentState!.validate()) {
//                         Auth().registration(_emailController.text,
//                             _passwordController.text, context);
//                       }
//                     }),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "--OR--",
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         text: "Already an user?  ",
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.w300,
//                           color: Colors.black,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: "Log In",
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.violetColor,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () => Get.toNamed(signIn),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
