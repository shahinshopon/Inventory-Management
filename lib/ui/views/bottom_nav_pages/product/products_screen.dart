import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:launch_review/launch_review.dart';
import 'package:tamplates_app/business_logics/auth_helper.dart';
import 'package:tamplates_app/const/app_colors.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/product/add_new_product.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/product/product_edit_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/product/selected_product_screen.dart';
import 'package:tamplates_app/ui/widgets/app_buttons.dart';
import 'package:tamplates_app/ui/widgets/custom_appbar.dart';
import 'package:tamplates_app/ui/widgets/drawer_items.dart';
import '../../../route/route.dart';
import '../../../widgets/text_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool ascending = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool open = true;
  TextEditingController searchController = TextEditingController();
  String name = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            )),
        title: Text(
          "All Products",
          style: TextStyle(fontSize: 20.w, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check_box,
                color: Colors.black,
              ),
              onPressed: () {
                Get.to(SelectedAllProductscreen());
              }),
          open
              ? IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      open = !open;
                    });
                  })
              : SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: TextFormField(
                            controller: searchController,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.text,
                            onChanged: (textEntered) {
                              setState(() {
                                // usernameText = textEntered.toUpperCase();
                                // searchController.value = TextEditingValue(
                                //     selection: searchController.selection,
                                //     text: capitalize(textEntered));

                                // initSearchingpost(textEntered);
                                name = textEntered;
                              });
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              open = !open;
                              name = '';
                            });
                            // initSearchingpost(usernameText);
                            searchController.clear();
                          }),
                    ],
                  ),
                )
        ],
      ),
      body: StreamBuilder(
          stream: _firestore
              .collection('all-data')
              .orderBy('productName', descending: ascending)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            ascending = !ascending;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text(
                                'Product Name',
                                style: AppStyles.titleStyle,
                              ),
                              Icon(ascending
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward)
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var indexData = snapshot.data.docs[index].data()
                                  as Map<String, dynamic>;
                              if (name.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchController.clear();
                                      open = true;
                                    });
                                    Get.to(ProductEditScreen(
                                        indexData['productName'],
                                        indexData['deptCategory']));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(indexData['productName']),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (indexData['productName']
                                  .toString()
                                  .startsWith(name.capitalizeFirst!)) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchController.clear();
                                      open = true;
                                    });
                                    Get.to(ProductEditScreen(
                                        indexData['productName'],
                                        indexData['deptCategory']));
                                  },
                                  child: Card(
                                    child: ListTile(
                                      title: Text(indexData['productName']),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }),
                      ),
                    ],
                  )
                : CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.greenAccent,
        onPressed: () {
          var routeBoxOne = GetStorage();
          routeBoxOne.write('routeBoxOne', 'product');
          setState(() {
            searchController.clear();
            open = true;
          });
          Get.to(AddNewProductForProductScreen('product'));
        },
        child: Icon(
          Icons.add,
          size: 35.w,
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 100.h, left: 20.w),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      AppString.bookImage,
                      height: 50.h,
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(
                      AppString.myPrepper,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                drawerItemMobile(Icons.drag_handle, AppString.user, () {
                  Get.toNamed(userProfile);
                }),
                drawerItemMobile(
                    Icons.speaker_phone, AppString.assistant, () {}),
                SizedBox(
                  height: 30.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                drawerItemMobile(Icons.question_mark, AppString.about, () {
                  Get.toNamed(about);
                }),
                drawerItemMobile(Icons.share, AppString.share, () {
                  LaunchReview.launch(
                      androidAppId: 'com.example.tamplates_app');
                }),
                SizedBox(
                  height: 25.h,
                ),
                const Divider(
                  color: Colors.black,
                ),
                drawerItemMobile(Icons.logout, "Logout", () {
                  Auth().signOut();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
