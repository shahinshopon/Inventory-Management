import 'package:get/get.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/drawer/about_screen.dart';
import 'package:tamplates_app/ui/views/auth/forgot_pass.dart';
import 'package:tamplates_app/ui/views/auth/sign_in.dart';
import 'package:tamplates_app/ui/views/auth/sign_up.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/inventory_add_screen.dart';
import 'package:tamplates_app/ui/views/splash_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/drawer/user_profile.dart';
import 'package:tamplates_app/ui/views/auth/user_screen.dart';

const String splash = '/splash-screen';
const String user = '/user-screen';
const String inventory = '/inventory-screen';
const String about = '/About-screen';
const String signIn = '/sign-in';
//const String signUp = '/sign-up';
const String home = '/home-screen';
const String userProfile = '/user-profile-screen';
// const String resetPass = '/reset-password';

List<GetPage> getPages = [
  GetPage(
    name: splash,
    page: () => const SplashScreen(),
  ),
  // GetPage(
  //   name: signUp,
  //   page: () => SignUp(),
  // ),
  GetPage(
    name: signIn,
    page: () => SignIn(),
  ),
  // GetPage(
  //   name: resetPass,
  //   page: () => ForgotPassword(),
  // ),
  GetPage(
      name: user,
      page: () {
        UserScreen _userScreen = Get.arguments;
        return _userScreen;
      }),
  GetPage(
    name: home,
    page: () {
      HomeScreen _homeScreen = Get.arguments;
      return _homeScreen;
    },
  ),
  GetPage(
    name: inventory,
    page: () => const InventoryAddScreen(),
  ),
  GetPage(
    name: about,
    page: () => const AboutScreen(),
  ),
  GetPage(
    name: userProfile,
    page: () => const UserProfile(),
  ),
];
