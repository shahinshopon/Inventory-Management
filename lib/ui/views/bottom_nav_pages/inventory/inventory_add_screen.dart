import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/add_new_field_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/product/add_new_product.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/widgets/app_buttons.dart';
import 'package:tamplates_app/ui/widgets/custom_appbar.dart';
import 'package:tamplates_app/ui/widgets/custom_icons.dart';
import 'package:tamplates_app/ui/widgets/text_widget.dart';

class InventoryAddScreen extends StatefulWidget {
  const InventoryAddScreen({Key? key}) : super(key: key);

  @override
  State<InventoryAddScreen> createState() => _InventoryAddScreenState();
}

class _InventoryAddScreenState extends State<InventoryAddScreen> {
  String? selectedProduct;
  List listOfProduct = [];
  String? selectedTerm;
  List listOfTerm = [];
  String? selectedContainer;
  List listOfContainer = [];
  String? selectedMeasure;
  List listOfMeasure = [];
  String? selectedRoom;
  List listOfRoom = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //select first exp. date
  Rx<TextEditingController> _firstdobController = TextEditingController().obs;
  String? firstdob;
  Rx<DateTime> selectedFirstDate = DateTime.now().obs;

  _selectFirstDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedFirstDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selected != null && selected != selectedFirstDate) {
      firstdob = "${selected.month} - ${selected.day} - ${selected.year}";
      _firstdobController.value.text = firstdob!;
    }
  }

  //select last exp. date
  Rx<TextEditingController> _lastdobController = TextEditingController().obs;
  String? lastdob;
  Rx<DateTime> selectedLastDate = DateTime.now().obs;

  _selectLastDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedLastDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selected != null && selected != selectedLastDate) {
      lastdob = "${selected.month} - ${selected.day} - ${selected.year}";
      _lastdobController.value.text = lastdob!;
    }
  }

  //amout
  Rx<TextEditingController> _amountController = TextEditingController().obs;
  RxInt amount = 0.obs;
  //desired
  Rx<TextEditingController> _desiredController = TextEditingController().obs;
  RxInt desired = 0.obs;
  //measureAmount
  Rx<TextEditingController> _measureAmountController =
      TextEditingController().obs;
  RxInt measureAmount = 0.obs;
  //section
  Rx<TextEditingController> _sectionController = TextEditingController().obs;
  RxInt section = 0.obs;
  //shelf
  Rx<TextEditingController> _shelfController = TextEditingController().obs;
  RxInt shelf = 0.obs;
  //item
  Rx<TextEditingController> _itemController = TextEditingController().obs;
  RxInt item = 0.obs;
  final _formkey = GlobalKey<FormState>();
  TextEditingController depCategorySearchController = TextEditingController();

  //add new controller
  // TextEditingController _addTermController = TextEditingController();
  // TextEditingController _addContainerController = TextEditingController();
  // TextEditingController _addMeasureController = TextEditingController();
  // TextEditingController _addRoomController = TextEditingController();
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(
          title: "My Inventory(Add)",
          onPress: () {
            Get.toNamed(home, arguments: HomeScreen(1));
          },
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(top: 25.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formkey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText("Product *"),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: StreamBuilder(
                          stream: _firestore.collection('all-data').snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            listOfProduct.clear();
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              listOfProduct.add(snap['productName']);
                            }

                            return Padding(
                              padding: AppStyles.kRegularPadding,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfProduct.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedProduct = val as String;
                                    setState(() {});
                                  },
                                  dropdownMaxHeight: 400,
                                  value: selectedProduct,
                                  searchController: depCategorySearchController,
                                  searchInnerWidget: TextFormField(
                                    controller: depCategorySearchController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                          }),
                    ),
                    addNewbutton(() {
                      var routeBoxTwo = GetStorage();
                      routeBoxTwo.write('routeBoxTwo', 'addInventory');
                      Get.to(AddNewProductForProductScreen('addInventory'));
                    }),
                    titleText("Term *"),
                    Container(
                      width: double.infinity,
                      decoration: AppStyles.borderDecoration,
                      child: StreamBuilder(
                          stream: _firestore
                              .collection('term')
                              .orderBy('term', descending: false)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            listOfTerm.clear();
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              listOfTerm.add(snap['term']);
                            }

                            return Padding(
                              padding: AppStyles.kRegularPadding,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfTerm.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedTerm = val as String;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfTerm.clear();
                      Get.to(AddTermScreen());
                      // showDialog(
                      //     context: context,
                      //     builder: (_) {
                      //       return AlertDialog(
                      //         content: Container(
                      //           decoration: AppStyles.borderDecoration,
                      //           child: TextFormField(
                      //             controller: _addTermController,
                      //             decoration:
                      //                 InputDecoration(border: InputBorder.none),
                      //           ),
                      //         ),
                      //         actions: [
                      //           TextButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text('Close')),
                      //           TextButton(
                      //               onPressed: () {
                      //                 FirebaseFirestore.instance
                      //                     .collection('deptCategory')
                      //                     .doc("QN8yRyDDwYUMw8H7Nbui")
                      //                     .update({
                      //                   "term": FieldValue.arrayUnion(
                      //                       [_addTermController.text])
                      //                 }).then((value) {
                      //                   Navigator.pop(context);
                      //                   _addTermController.clear();
                      //                 });
                      //               },
                      //               child: Text('Save')),
                      //         ],
                      //       );
                      //     });
                    }),
                    titleText(AppString.expire),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _firstdobController.value,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "dd-mm-yyyy",
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => _selectFirstDate(context),
                                  icon:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText(AppString.lastExpire),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _lastdobController.value,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: "dd-mm-yyyy",
                                hintStyle: TextStyle(
                                  fontSize: 15.sp,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => _selectLastDate(context),
                                  icon:
                                      const Icon(Icons.calendar_month_rounded),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText("Amount"),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _amountController.value,
                            style: AppStyles.titleStyle,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: amount.value.toString(),
                                hintStyle: AppStyles.titleStyle,
                                suffixIcon: SizedBox(
                                  width: 120.w,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          amount.value++;
                                        },
                                        icon: customIcons(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (amount.value > 0) {
                                            amount.value--;
                                          }
                                        },
                                        icon: customIcons(Icons.remove),
                                      ),
                                    ],
                                  ),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText("Desired"),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _desiredController.value,
                            style: AppStyles.titleStyle,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: desired.value.toString(),
                                hintStyle: AppStyles.titleStyle,
                                suffixIcon: SizedBox(
                                  width: 120.w,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          desired.value++;
                                        },
                                        icon: customIcons(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (desired.value > 0) {
                                            desired.value--;
                                          }
                                        },
                                        icon: customIcons(Icons.remove),
                                      ),
                                    ],
                                  ),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText("Container"),
                    Container(
                      width: double.infinity,
                      decoration: AppStyles.borderDecoration,
                      child: StreamBuilder(
                          stream: _firestore
                              .collection('container')
                              .orderBy('container', descending: false)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            listOfContainer.clear();
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              listOfContainer.add(snap['container']);
                            }

                            return Padding(
                              padding: AppStyles.kRegularPadding,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfContainer.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedContainer = val as String;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfContainer.clear();
                      Get.to(AddContainerScreen());
                      // showDialog(
                      //     context: context,
                      //     builder: (_) {
                      //       return AlertDialog(
                      //         content: Container(
                      //           decoration: AppStyles.borderDecoration,
                      //           child: TextFormField(
                      //             controller: _addContainerController,
                      //             decoration:
                      //                 InputDecoration(border: InputBorder.none),
                      //           ),
                      //         ),
                      //         actions: [
                      //           TextButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text('Close')),
                      //           TextButton(
                      //               onPressed: () {
                      //                 FirebaseFirestore.instance
                      //                     .collection('container')
                      //                     .doc("3fUb67mv9yHge3VyZ0Sd")
                      //                     .update({
                      //                   "container": FieldValue.arrayUnion(
                      //                       [_addContainerController.text])
                      //                 }).then((value) {
                      //                   Get.back();
                      //                   _addContainerController.clear();
                      //                 });
                      //               },
                      //               child: Text('Save')),
                      //         ],
                      //       );
                      //     });
                    }),
                    titleText("Measure Amount"),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _measureAmountController.value,
                            style: AppStyles.titleStyle,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: measureAmount.value.toString(),
                                hintStyle: AppStyles.titleStyle,
                                suffixIcon: SizedBox(
                                  width: 120.w,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          measureAmount.value++;
                                        },
                                        icon: customIcons(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (measureAmount.value > 0) {
                                            measureAmount.value--;
                                          }
                                        },
                                        icon: customIcons(Icons.remove),
                                      ),
                                    ],
                                  ),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText("Measure"),
                    Container(
                      width: double.infinity,
                      decoration: AppStyles.borderDecoration,
                      child: StreamBuilder(
                          stream: _firestore
                              .collection('measure')
                              .orderBy('measure', descending: false)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            listOfMeasure.clear();
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              listOfMeasure.add(snap['measure']);
                            }

                            return Padding(
                              padding: AppStyles.kRegularPadding,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfMeasure.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedMeasure = val as String;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfMeasure.clear();
                      Get.to(AddMeasureScreen());
                      // showDialog(
                      //     context: context,
                      //     builder: (_) {
                      //       return AlertDialog(
                      //         content: Container(
                      //           decoration: AppStyles.borderDecoration,
                      //           child: TextFormField(
                      //             controller: _addMeasureController,
                      //             decoration:
                      //                 InputDecoration(border: InputBorder.none),
                      //           ),
                      //         ),
                      //         actions: [
                      //           TextButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text('Close')),
                      //           TextButton(
                      //               onPressed: () {
                      //                 FirebaseFirestore.instance
                      //                     .collection('deptCategory')
                      //                     .doc("QN8yRyDDwYUMw8H7Nbui")
                      //                     .update({
                      //                   "measure": FieldValue.arrayUnion(
                      //                       [_addMeasureController.text])
                      //                 }).then((value) {
                      //                   Navigator.pop(context);
                      //                   _addMeasureController.clear();
                      //                 });
                      //               },
                      //               child: Text('Save')),
                      //         ],
                      //       );
                      //     });
                    }),
                    titleText("Room"),
                    Container(
                      width: double.infinity,
                      decoration: AppStyles.borderDecoration,
                      child: StreamBuilder(
                          stream: _firestore
                              .collection('room')
                              .orderBy('room', descending: false)
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            listOfRoom.clear();
                            for (int i = 0;
                                i < snapshot.data.docs.length;
                                i++) {
                              DocumentSnapshot snap = snapshot.data.docs[i];
                              listOfRoom.add(snap['room']);
                            }

                            return Padding(
                              padding: AppStyles.kRegularPadding,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfRoom.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedRoom = val as String;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfRoom.clear();
                      Get.to(AddRoomScreen());
                      // showDialog(
                      //     context: context,
                      //     builder: (_) {
                      //       return AlertDialog(
                      //         content: Container(
                      //           decoration: AppStyles.borderDecoration,
                      //           child: TextFormField(
                      //             controller: _addRoomController,
                      //             decoration:
                      //                 InputDecoration(border: InputBorder.none),
                      //           ),
                      //         ),
                      //         actions: [
                      //           TextButton(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text('Close')),
                      //           TextButton(
                      //               onPressed: () {
                      //                 FirebaseFirestore.instance
                      //                     .collection('deptCategory')
                      //                     .doc("QN8yRyDDwYUMw8H7Nbui")
                      //                     .update({
                      //                   "room": FieldValue.arrayUnion(
                      //                       [_addRoomController.text])
                      //                 }).then((value) {
                      //                   Navigator.pop(context);
                      //                   _addRoomController.clear();
                      //                 });
                      //               },
                      //               child: Text('Save')),
                      //         ],
                      //       );
                      //     });
                    }),
                    titleText("Section #"),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _sectionController.value,
                            style: AppStyles.titleStyle,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: section.value.toString(),
                                hintStyle: AppStyles.titleStyle,
                                suffixIcon: SizedBox(
                                  width: 120.w,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          section.value++;
                                        },
                                        icon: customIcons(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (section.value > 0) {
                                            section.value--;
                                          }
                                        },
                                        icon: customIcons(Icons.remove),
                                      ),
                                    ],
                                  ),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText("Shelf #"),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _shelfController.value,
                            style: AppStyles.titleStyle,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: shelf.value.toString(),
                                hintStyle: AppStyles.titleStyle,
                                suffixIcon: SizedBox(
                                  width: 120.w,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          shelf.value++;
                                        },
                                        icon: customIcons(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (shelf.value > 0) {
                                            shelf.value--;
                                          }
                                        },
                                        icon: customIcons(Icons.remove),
                                      ),
                                    ],
                                  ),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    titleText("Item #"),
                    Obx(
                      () => Container(
                        decoration: AppStyles.borderDecoration,
                        child: Padding(
                          padding: AppStyles.kRegularPadding,
                          child: TextFormField(
                            controller: _itemController.value,
                            style: AppStyles.titleStyle,
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: item.value.toString(),
                                hintStyle: AppStyles.titleStyle,
                                suffixIcon: SizedBox(
                                  width: 120.w,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          item.value++;
                                        },
                                        icon: customIcons(Icons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (item.value > 0) {
                                            item.value--;
                                          }
                                        },
                                        icon: customIcons(Icons.remove),
                                      ),
                                    ],
                                  ),
                                ),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        cancelButton(
                            () => Get.toNamed(home, arguments: HomeScreen(1))),
                        TextButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                _firestore
                                    .collection("my-inventory")
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection("my-data")
                                    .where('productName',
                                        isEqualTo: selectedProduct)
                                    .where('term', isEqualTo: selectedTerm)
                                    .get()
                                    .then((snapshot) {
                                  var dd = snapshot.docs;
                                  if (dd.isEmpty) {
                                    //add document name
                                    _firestore
                                        .collection("my-inventory")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .set({
                                      'email': FirebaseAuth
                                          .instance.currentUser!.email
                                    });
                                    //add inventory data
                                    _firestore
                                        .collection("my-inventory")
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.email)
                                        .collection("my-data")
                                        .doc('$selectedProduct $selectedTerm')
                                        .set({
                                      'productName': selectedProduct,
                                      'term': selectedTerm,
                                      'firstExp': firstdob,
                                      'lastexp': lastdob,
                                      'amount': amount.value,
                                      'desired': desired.value,
                                      'container': selectedContainer,
                                      'measureAmount': measureAmount.value,
                                      'measure': selectedMeasure,
                                      'room': selectedRoom,
                                      'section': section.value,
                                      'shelf': shelf.value,
                                      'item': item.value,
                                      'value': false
                                    }).whenComplete(() {
                                      Fluttertoast.showToast(
                                          msg: "New Inventory Added");
                                      _firestore
                                          .collection("all-data")
                                          // .doc(FirebaseAuth
                                          //     .instance.currentUser!.email)
                                          // .collection("my-data")
                                          .where('productName',
                                              isEqualTo: selectedProduct)
                                          .get()
                                          .then((snapshot) {
                                        var dd = snapshot.docs;
                                        if (dd.isNotEmpty) {
                                          _firestore
                                              .collection("all-data")
                                              // .doc(FirebaseAuth
                                              //     .instance.currentUser!.email)
                                              // .collection("my-data")
                                              .doc(selectedProduct)
                                              .update({'num': 2});
                                        }
                                      });
                                      Get.toNamed(home,
                                          arguments: HomeScreen(1));
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Already Added");
                                    Get.toNamed(home, arguments: HomeScreen(1));
                                  }
                                });
                              }
                            },
                            child: Text(
                              AppString.save,
                              style: TextStyle(
                                  fontSize: 20.sp, color: Colors.green),
                            )),
                      ],
                    ),
                  ]),
            ),
          ),
        )));
  }
}
