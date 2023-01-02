import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:tamplates_app/business_logics/auth_helper.dart';
import 'package:tamplates_app/const/app_colors.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/inventory_edit_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/selected_inventory_screen.dart';
import 'package:tamplates_app/ui/widgets/drawer_items.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt _currentIndex = 0.obs;
  bool open = true;
  //String usernameText = '';
  // Future<QuerySnapshot>? postdocumentList;

  // initSearchingpost(String textEntered) {
  //   postdocumentList = FirebaseFirestore.instance
  //       .collection('my-inventory')
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .collection("my-data")
  //       .where('productName', isGreaterThanOrEqualTo: textEntered)
  //       .get();
  //   setState(() {
  //     postdocumentList;
  //   });
  // }

  TextEditingController searchController = TextEditingController();

  // String capitalize(String textEntered) {
  //   if (textEntered.trim().isEmpty) {
  //     return "";
  //   } else {
  //     return "${textEntered[0].toUpperCase()}${textEntered.substring(1).toLowerCase()}";
  //   }
  // }

  String name = '';

  bool ascendingProduct = false;
  bool ascendingTerm = false;
  bool ascendingAmount = false;
  bool ascendingExpire = false;
  String order = 'productName';
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
          "My Inventory(Add)",
          style: TextStyle(fontSize: 20.w, color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.check_box,
                color: Colors.black,
              ),
              onPressed: () {
                Get.to(SelectedInventoryScreen());
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
                                name = textEntered;
                                // usernameText = textEntered.toUpperCase();
                                // searchController.value = TextEditingValue(
                                //     selection: searchController.selection,
                                //     text: capitalize(textEntered));
                              });
                              // initSearchingpost(textEntered);
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
      body: Column(
        children: [
          Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder.symmetric(
                inside: BorderSide.none,
                outside: const BorderSide(
                    width: 0.5, color: Colors.grey, style: BorderStyle.solid),
              ),
              columnWidths: const {
                0: FlexColumnWidth(6),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(5),
                3: FlexColumnWidth(6),
                4: FlexColumnWidth(3),
              }, // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          ascendingProduct = !ascendingProduct;
                          order = 'productName';
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          children: [
                            Text(
                              'Product ',
                              style: TextStyle(fontSize: 17.sp),
                            ),
                            Icon(ascendingProduct
                                ? Icons.arrow_upward
                                : Icons.arrow_downward)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        ascendingTerm = !ascendingTerm;
                        order = 'term';
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        children: [
                          Text(
                            'Term',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          Icon(ascendingTerm
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                        ],
                      ),
                    ),
                  )),
                  Center(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        ascendingAmount = !ascendingAmount;
                        order = 'amount';
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        children: [
                          Text(
                            'Amount',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          Icon(ascendingAmount
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                        ],
                      ),
                    ),
                  )),
                  Center(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        ascendingExpire = !ascendingExpire;
                        order = 'firstExp';
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        children: [
                          Text(
                            '1st Expire',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          Icon(ascendingExpire
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                        ],
                      ),
                    ),
                  )),
                 // const Center(child: Icon(Icons.arrow_forward_ios))
                ]),
              ]),
          StreamBuilder(
              stream: _firestore
                  .collection('my-inventory')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("my-data")
                  .orderBy(order,
                      descending: order == 'term'
                          ? ascendingTerm
                          : order == 'amount'
                              ? ascendingAmount
                              : order == 'firstExp'
                                  ? ascendingExpire
                                  : ascendingProduct)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var indexData = snapshot.data.docs[index].data()
                                  as Map<String, dynamic>;
                              if (name.isEmpty) {
                                return Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    border: TableBorder.symmetric(
                                      inside: BorderSide.none,
                                      outside: const BorderSide(
                                          width: 0.5,
                                          color: Colors.grey,
                                          style: BorderStyle.solid),
                                    ),
                                    columnWidths: const {
                                      0: FlexColumnWidth(6),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(4),
                                      3: FlexColumnWidth(6),
                                      4: FlexColumnWidth(3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Center(
                                            child:
                                                Text(indexData['productName'])),
                                        Center(child: Text(indexData['term'])),
                                        Center(
                                            child: Text(
                                                '${indexData['amount']}' == null
                                                    ? ""
                                                    : '${indexData['amount']}')),
                                        Center(
                                            child: Text(
                                                indexData['firstExp'] ?? "")),
                                        Center(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  searchController.clear();
                                                  open = true;
                                                   name = '';
                                                });
                                                Get.to(EditInventoryField(
                                                  indexData['productName'],
                                                  indexData['term'],
                                                  indexData['firstExp'],
                                                  indexData['lastexp'],
                                                  indexData['amount'],
                                                  indexData['desired'],
                                                  indexData['container'],
                                                  indexData['measureAmount'],
                                                  indexData['measure'],
                                                  indexData['room'],
                                                  indexData['section'],
                                                  indexData['shelf'],
                                                  indexData['item'],
                                                ));
                                              },
                                              icon: const Icon(
                                                  Icons.arrow_forward_ios)),
                                        )
                                      ])
                                    ]);
                              }
                              if (indexData['productName']
                                  .toString()
                                  .startsWith(name.capitalizeFirst!)) {
                                return Table(
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    border: TableBorder.symmetric(
                                      inside: BorderSide.none,
                                      outside: const BorderSide(
                                          width: 0.5,
                                          color: Colors.grey,
                                          style: BorderStyle.solid),
                                    ),
                                    columnWidths: const {
                                      0: FlexColumnWidth(6),
                                      1: FlexColumnWidth(4),
                                      2: FlexColumnWidth(5),
                                      3: FlexColumnWidth(6),
                                      4: FlexColumnWidth(3),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Center(
                                            child:
                                                Text(indexData['productName'])),
                                        Center(child: Text(indexData['term'])),
                                        Center(
                                            child: Text(
                                                '${indexData['amount']}' == null
                                                    ? ""
                                                    : '${indexData['amount']}')),
                                        Center(
                                            child: Text(
                                                indexData['firstExp'] ?? "")),
                                        Center(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  searchController.clear();
                                                  open = true;
                                                   name = '';
                                                });
                                                Get.to(EditInventoryField(
                                                  indexData['productName'],
                                                  indexData['term'],
                                                  indexData['firstExp'],
                                                  indexData['lastexp'],
                                                  indexData['amount'],
                                                  indexData['desired'],
                                                  indexData['container'],
                                                  indexData['measureAmount'],
                                                  indexData['measure'],
                                                  indexData['room'],
                                                  indexData['section'],
                                                  indexData['shelf'],
                                                  indexData['item'],
                                                ));
                                              },
                                              icon: const Icon(
                                                  Icons.arrow_forward_ios)),
                                        )
                                      ])
                                    ]);
                              }
                              return Container();
                            }),
                      )
                    : const CircularProgressIndicator();
              })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.greenAccent,
        onPressed: () {
          setState(() {
            searchController.clear();
            open = true;
            name = '';
          });
          Get.toNamed(inventory);
        },
        child: Icon(Icons.add, size: 35.w),
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
