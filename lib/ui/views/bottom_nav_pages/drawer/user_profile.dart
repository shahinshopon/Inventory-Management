import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/widgets/text_widget.dart';
import '../../../widgets/custom_appbar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: "User",
        onPress: () {
           Get.toNamed(home, arguments: HomeScreen(0));
          },
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('all-user')
                      .doc(FirebaseAuth.instance.currentUser!.email.toString())
                      // .where('email',
                      //     isEqualTo: FirebaseAuth.instance.currentUser!.email)
                      .get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    final docs = snapshot.data;
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: Image.network(
                                    docs!['img'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  titleText("Email :"),
                                  AppStyles.horizontallySizedbox,
                                  titleText(docs['email']),
                                ],
                              ),
                              //  AppStyles.verticallySizedbox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  titleText("First name :"),
                                  AppStyles.horizontallySizedbox,
                                  titleText(docs['first_name']),
                                ],
                              ),
                              //AppStyles.verticallySizedbox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  titleText("Last name :"),
                                  AppStyles.horizontallySizedbox,
                                  titleText(docs['last_name'])
                                ],
                              ),
                              // AppStyles.verticallySizedbox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  titleText("Phone Number :"),
                                  AppStyles.horizontallySizedbox,
                                  titleText(docs['phone_number'])
                                ],
                              ),
                              //AppStyles.verticallySizedbox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  titleText("Role :"),
                                  AppStyles.horizontallySizedbox,
                                  titleText(docs['role'])
                                ],
                              ),
                              // AppStyles.verticallySizedbox,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  titleText("Type :"),
                                  AppStyles.horizontallySizedbox,
                                  titleText(docs['type'])
                                ],
                              ),
                            ],
                          );
                    
                  }))),
    );
  }
}
