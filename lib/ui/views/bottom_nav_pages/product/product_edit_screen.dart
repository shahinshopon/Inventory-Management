


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tamplates_app/const/app_colors.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/product/add_new_product.dart';
import 'package:tamplates_app/ui/widgets/app_buttons.dart';
import 'package:tamplates_app/ui/widgets/custom_appbar.dart';
import 'package:tamplates_app/ui/widgets/text_widget.dart';

class ProductEditScreen extends StatefulWidget {
  var productName;
  var deptCategory;
  ProductEditScreen(this.productName, this.deptCategory);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _formkey = GlobalKey<FormState>();

  String? selectedRole;

  List listOfRole = [];

  TextEditingController depCategorySearchController = TextEditingController();
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          title: 'Edit Product',
          onPress: () {
            Get.toNamed(home, arguments: HomeScreen(0));
          }),
      body: SafeArea(
          child: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText("ProductName"),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black54,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.productName,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                  ),
                ),
                titleText("DeptCategory"),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: StreamBuilder(
                        stream: _firestore
                            .collection('department-category')
                            .orderBy('depCategory', descending: false)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          listOfRole.clear();
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            listOfRole.add(snap['depCategory']);
                          }

                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                value: selectedRole,
                                hint: Text(widget.deptCategory),
                                items: listOfRole.map((document) {
                                  return DropdownMenuItem(
                                      value: document, child: Text(document));
                                }).toList(),
                                onChanged: (val) {
                                  selectedRole = val as String;
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                searchController: depCategorySearchController,
                                searchInnerWidget: TextFormField(
                                  controller: depCategorySearchController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 16,
                                    ),
                                    hintText: 'Search for an item...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.to(
                        SelectDepartmentForProductScreen("ProductEditScreen"));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit_note,
                        color: AppColors.greenAccent,
                        size: 20.w,
                      ),
                      Text(
                        "Add new",
                        style: TextStyle(
                            fontSize: 20.sp, color: AppColors.greenAccent),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    cancelButton(
                      () => Get.toNamed(home, arguments: HomeScreen(0)),
                    ),
                    TextButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _firestore
                                .collection("all-data")
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection("my-data")
                                .where('productName',
                                    isEqualTo: widget.productName)
                                .get()
                                .then((snapshot) {
                              var data = snapshot.docs;
                              if (data.isNotEmpty) {
                               _firestore
                                    .collection("all-data")
                                    .doc(widget.productName)
                                    .update({
                                  "deptCategory": selectedRole
                                }).whenComplete(() {
                                  Fluttertoast.showToast(msg: "Uploaded");
                                  Get.toNamed(home, arguments: HomeScreen(0));
                                });
                              } else {
                                Fluttertoast.showToast(msg: "Can't Change");
                                Get.toNamed(home, arguments: HomeScreen(0));
                              }
                            });
                          }
                        },
                        child: Text(
                          AppString.save,
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.green),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
