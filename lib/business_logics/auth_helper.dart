import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/views/auth/sign_in.dart';
import 'package:tamplates_app/ui/views/auth/verify_email.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/views/auth/user_screen.dart';

class Auth {
  final box = GetStorage();

  // Future registration(String emailAddress, String password, context) async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: emailAddress, password: password);
  //     var authCredential = userCredential.user;
  //     if (authCredential!.uid.isNotEmpty) {
  //       // Fluttertoast.showToast(msg: 'Registration Successfull');
  //       //display user name
  //       // userCredential.user!.updateDisplayName(name);
  //       // await _firestore
  //       //     .collection('users')
  //       //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //       //     .set({"email": emailAddress, "password": password});
  //       // await box.write("uid", authCredential.uid);
  //       // print(box.read('uid'));
  //       // box.write("store", emailAddress);
  //       // await box.write("check", true);
  //       box.write('uid', authCredential.uid);
  //       Get.to(VerifyEmail());
  //       // final userCredential = await FirebaseAuth.instance
  //       //     .signInWithEmailLink(email: emailAddress, emailLink: emailAddress);
  //       //     Fluttertoast.showToast(msg: 'sent email');
  //       // try {
  //       //   await FirebaseAuth.instance.currentUser
  //       //       ?.linkWithCredential(userCredential.credential!);
  //       //   Get.toNamed(user, arguments: UserScreen(emailAddress));
  //       // } catch (error) {
  //       //   print("Error linking emailLink credential.");
  //       // }
  //       // try {
  //       //   FirebaseAuth.instance
  //       //       .signInWithEmailLink(email: emailAddress, emailLink: emailAddress)
  //       //       .then((value) =>
  //       //           Get.toNamed(user, arguments: UserScreen(emailAddress)));
  //       // } catch (e) {
  //       //   print(e.toString());
  //       // }
  //       // Get.toNamed(user, arguments: UserScreen(emailAddress));
  //     } else {
  //       Fluttertoast.showToast(msg: "sign up failed");
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       Fluttertoast.showToast(msg: 'The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       Fluttertoast.showToast(
  //           msg: 'The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'Error is: $e');
  //   }
  // }

  // Future login(String emailAddress, String password, context) async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: emailAddress, password: password);
  //     var authCredential = userCredential.user;
  //     // print(authCredential);
  //     if (authCredential!.uid.isNotEmpty) {
  //       // await box.write("uid", authCredential.uid);
  //       // print(box.read('uid'));
  //       // box.write("store", emailAddress);
  //       // box.write("check", true);
  //       // var check = box.read("user");
  //       // check==true?  Get.toNamed(user, arguments: UserScreen(emailAddress)):Get.toNamed(home);
  //       // Get.toNamed(user, arguments: UserScreen(emailAddress));
  //       box.write('luid', authCredential.uid);
  //       FirebaseFirestore.instance
  //           .collection("all-user")
  //           .where('email', isEqualTo: emailAddress)
  //           .get()
  //           .then((snapshot) {
  //             snapshot.docs.isEmpty?
  //             Get.snackbar("Alert", "This is not valid email.\nPlease follow our signup procedure",duration: Duration(seconds: 4))
  //             :Get.toNamed(home,arguments: HomeScreen(0));
  //       });
  //      // Get.toNamed(home);
  //     } else {
  //       Fluttertoast.showToast(msg: "sign up failed");
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       Fluttertoast.showToast(msg: 'The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       Fluttertoast.showToast(
  //           msg: 'The account already exists for that email.');
  //     } else if (e.code == 'invalid-email') {
  //       // Fluttertoast.showToast(msg: "This email doesn't match.");
  //       Get.snackbar("Alert", "This email doesn't match.");
  //     } else if (e.code == 'wrong-password') {
  //       Get.snackbar("Alert", "This password doesn't match.");
  //       // Fluttertoast.showToast(msg: "This password doesn't match.");
  //     } else {
  //       Get.snackbar("Alert", "This email doesn't match.");
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: 'Error is: $e');
  //   }
  // }
  
    signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      var recentUser = userCredential.user;

      if (recentUser!.uid.isNotEmpty) {
        box.write('luid', recentUser.uid);
        print('success');
        print(recentUser.displayName);
        print(recentUser.email);
        print(recentUser.uid);
        print(recentUser.phoneNumber);
        FirebaseFirestore.instance
            .collection("all-user")
            .where('email', isEqualTo: recentUser.email.toString())
            .get()
            .then((snapshot) {
          snapshot.docs.isEmpty
              ? Get.toNamed(user, arguments: UserScreen(recentUser.email))
              : Get.toNamed(home, arguments: HomeScreen(0));
        });

        // if (box.read("user") == null) {
        //   Get.toNamed(user, arguments: UserScreen(recentUser.email));
        // } else {
        //   Get.toNamed(home, arguments: HomeScreen(0));
        // }
      }
    } catch (e) {
      print('failed');
    }
  }

  Future signOut() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var box = GetStorage();
    try {
      GoogleSignIn().signOut();
      box.remove('luid');
      await _auth.signOut().then((value) {
        Get.to(SignIn());
       // box.remove('luid');
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }
}
