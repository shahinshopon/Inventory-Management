import 'package:cloud_firestore/cloud_firestore.dart';
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

class EditInventoryField extends StatefulWidget {
  var productName;
  var term;
  var firstExp;
  var lastExp;
  int _amount;
  int _desired;
  var container;
  int _measureAmount;
  var measure;
  var room;
  int _section;
  int _shelf;
  int _item;
  EditInventoryField(
      this.productName,
      this.term,
      this.firstExp,
      this.lastExp,
      this._amount,
      this._desired,
      this.container,
      this._measureAmount,
      this.measure,
      this.room,
      this._section,
      this._shelf,
      this._item);

  @override
  State<EditInventoryField> createState() => _EditInventoryFieldState();
}

class _EditInventoryFieldState extends State<EditInventoryField> {
  //List
  List listOfProduct = [];
  List listOfTerm = [];
  List listOfContainer = [];
  List listOfMeasure = [];
  List listOfRoom = [];
  //time
  Rx<DateTime> selectedFirstDate = DateTime.now().obs;
  Rx<DateTime> selectedLastDate = DateTime.now().obs;

  //controller
  Rx<TextEditingController> _firstdobController = TextEditingController().obs;
  Rx<TextEditingController> _lastdobController = TextEditingController().obs;
  Rx<TextEditingController> _amountController = TextEditingController().obs;
  Rx<TextEditingController> _desiredController = TextEditingController().obs;
  Rx<TextEditingController> _measureAmountController =
      TextEditingController().obs;
  Rx<TextEditingController> _sectionController = TextEditingController().obs;
  Rx<TextEditingController> _shelfController = TextEditingController().obs;
  Rx<TextEditingController> _itemController = TextEditingController().obs;
  TextEditingController productSearchController = TextEditingController();
  //key
  final _formkey = GlobalKey<FormState>();
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add new controller
  @override
  Widget build(BuildContext context) {
    String selectedProduct = widget.productName;
    String selectedTerm = widget.term;
    var firstdob = widget.firstExp;
    var lastdob = widget.lastExp;
    RxInt amount = widget._amount.obs;
    RxInt desired = widget._desired.obs;
    RxInt measureAmount = widget._measureAmount.obs;
    RxInt section = widget._section.obs;
    RxInt shelf = widget._shelf.obs;
    RxInt item = widget._item.obs;
    var selectedContainer = widget.container;
    var selectedMeasure = widget.measure;
    var selectedRoom = widget.room;
    //select First date
    _selectFirstDate(BuildContext context) async {
      final selected = await showDatePicker(
        context: context,
        initialDate: selectedFirstDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
      );

      if (selected != null && selected != selectedFirstDate) {
        firstdob = "${selected.month} - ${selected.day} - ${selected.year}";
        _firstdobController.value.text = firstdob;
      }
    }

    //select Last date
    _selectLastDate(BuildContext context) async {
      final selected = await showDatePicker(
        context: context,
        initialDate: selectedLastDate.value,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
      );

      if (selected != null && selected != selectedLastDate) {
        lastdob = "${selected.month} - ${selected.day} - ${selected.year}";
        _lastdobController.value.text = lastdob;
      }
    }

    return Scaffold(
        appBar: customAppbar(
          title: "My Inventory(Edit)",
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
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.productName,
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),
                    addNewbutton(() {
                      var routeBoxThree = GetStorage();
                      routeBoxThree.write('routeBoxThree', 'editInventory');
                      routeBoxThree.write('selectedProduct', selectedProduct);
                      routeBoxThree.write('selectedTerm', selectedTerm);
                      routeBoxThree.write('firstdob', firstdob);
                      routeBoxThree.write('lastdob', lastdob);
                      routeBoxThree.write('amount', widget._amount);
                      routeBoxThree.write('desired', widget._desired);
                      routeBoxThree.write(
                          'measureAmount', widget._measureAmount);
                      routeBoxThree.write('section', widget._section);
                      routeBoxThree.write('shelf', widget._shelf);
                      routeBoxThree.write('item', widget._item);
                      routeBoxThree.write(
                          'selectedContainer', selectedContainer);
                      routeBoxThree.write('selectedMeasure', selectedMeasure);
                      routeBoxThree.write('selectedRoom', selectedRoom);

                      Get.to(AddNewProductForProductScreen('editInventory'));
                    }),
                    titleText("Term *"),
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.term,
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                      ),
                    ),
                    addNewbutton(() {
                      listOfTerm.clear();
                      Get.to(AddTermScreen());
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
                                hintText: firstdob ?? "dd-mm-yyyy",
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
                                hintText: lastdob ?? "dd-mm-yyyy",
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
                                  hint: Text(selectedContainer ?? ""),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfContainer.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedContainer = val as String;
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfContainer.clear();
                      Get.to(AddContainerScreen());
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
                                  hint: Text(selectedMeasure ?? ""),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfMeasure.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedMeasure = val as String;
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfMeasure.clear();
                      Get.to(AddMeasureScreen());
                    }),
                    titleText("Room"),
                    Container(
                      width: double.infinity,
                      decoration: AppStyles.borderDecoration,
                      child: StreamBuilder(
                          stream:_firestore
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
                                  hint: Text(selectedRoom ?? ""),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                  items: listOfRoom.map((document) {
                                    return DropdownMenuItem(
                                        value: document, child: Text(document));
                                  }).toList(),
                                  onChanged: (val) {
                                    selectedRoom = val as String;
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    addNewbutton(() {
                      listOfRoom.clear();
                      Get.to(AddRoomScreen());
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
                                    .doc('${widget.productName} ${widget.term}')
                                    .update({
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
                                  'item': item.value
                                }).whenComplete(() {
                                  Fluttertoast.showToast(
                                      msg: "Inventory Updated");
                                  Get.toNamed(home, arguments: HomeScreen(1));
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
