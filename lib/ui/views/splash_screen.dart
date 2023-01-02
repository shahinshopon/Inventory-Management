import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/views/auth/user_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  Future chooseScreen() async {
    var logId = box.read('luid');
    var proId = box.read("user");
    if (logId == null ) {
      Get.toNamed(signIn);
    }
   else if (proId == null) {
      Get.toNamed(user,
          arguments: UserScreen(FirebaseAuth.instance.currentUser!.email));
    }
    else {
      Get.toNamed(home, arguments: HomeScreen(0));
    }
  }

  // Future chooseScreen() async {
  //   var userId = box.read('uid');
  //   var logId = box.read('luid');
  //   var proId = box.read("user");
  //   var verify = box.read("verify");
  //   if (logId == null) {
  //     userId == null || verify == null
  //         ? Get.toNamed(signUp)
  //         : proId == null
  //             ? Get.toNamed(user,
  //                 arguments:
  //                     UserScreen(FirebaseAuth.instance.currentUser!.email))
  //             : Get.toNamed(signIn);
  //   } else {
  //     Get.toNamed(home, arguments: HomeScreen(0));
  //   }
  // }

  @override
  initState() {
    Future.delayed(const Duration(seconds: 3), () {
      chooseScreen();
    
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Templates App",
            style: TextStyle(fontSize: 40.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
