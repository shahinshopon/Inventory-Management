// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:tamplates_app/ui/styles/styles.dart';
// import 'package:tamplates_app/ui/views/auth/user_screen.dart';
// import 'package:tamplates_app/ui/widgets/custom_appbar.dart';

// class VerifyEmail extends StatefulWidget {
//   const VerifyEmail({super.key});

//   @override
//   State<VerifyEmail> createState() => _VerifyEmailState();
// }

// class _VerifyEmailState extends State<VerifyEmail> {
//   bool isEmailVerified = false;
//   Timer? timer;
//   @override
//   void initState() {
//     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     if (!isEmailVerified) {
//       sendverificationEmail();
//       timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
      
     
//     }

//     super.initState();
//   }

//   sendverificationEmail() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser!;
//       await user.sendEmailVerification();
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }

//   Future checkEmailVerified() async {
//     await FirebaseAuth.instance.currentUser!.reload();
//     setState(() {
//       isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     });
//     if (isEmailVerified) timer?.cancel();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) => isEmailVerified
//       ? UserScreen(FirebaseAuth.instance.currentUser!.email)
//       : Scaffold(
//           appBar: customAppbar(title: "Verify Email",onPress: () {
//             Get.back();
//           },),
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("A verification Email has sent to your Email",
//                   style: AppStyles.titleStyle),
//               AppStyles.horizontallySizedbox,
//               Text("${FirebaseAuth.instance.currentUser!.email}",
//                   style: AppStyles.titleStyle),
//               AppStyles.horizontallySizedbox,
//               ElevatedButton(
//                   onPressed: sendverificationEmail,
//                   child: Text(
//                     "Resend Email",
//                     style: AppStyles.titleStyle,
//                   )),
//               AppStyles.horizontallySizedbox,
//               ElevatedButton(
//                   onPressed: () => Get.back(),
//                   child: Text("Cancel", style: AppStyles.titleStyle))
//             ],
//           ),
//         );
// }
