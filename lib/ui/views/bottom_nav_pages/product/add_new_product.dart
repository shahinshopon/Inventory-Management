import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/home/home_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/inventory_edit_screen.dart';
import 'package:tamplates_app/ui/views/bottom_nav_pages/inventory/inventory_add_screen.dart';
import 'package:tamplates_app/ui/widgets/app_buttons.dart';
import 'package:tamplates_app/ui/widgets/custom_appbar.dart';
import 'package:tamplates_app/ui/widgets/text_from_field.dart';
import 'package:tamplates_app/ui/widgets/text_widget.dart';

class AddNewProductForProductScreen extends StatefulWidget {
  var routeName;
  AddNewProductForProductScreen(this.routeName);
  @override
  State<AddNewProductForProductScreen> createState() =>
      _AddNewProductForProductScreenState();
}

class _AddNewProductForProductScreenState
    extends State<AddNewProductForProductScreen> {
  String? depyCategory;
  String? selectedRole;
  String? selectedDepartment;
  String? selectedCategory;
  List listOfRole = [];
  List listOfDepartment = [];
  List listOfCategory = [];
  RxBool load = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController depCategorySearchController = TextEditingController();
  late SingleValueDropDownController _cnt3;
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String usernameText = '';
  Future<QuerySnapshot>? postdocumentList;
  initSearchingpost(String textEntered) {
    postdocumentList = FirebaseFirestore.instance
        .collection('check')
        .where('depCategory', isGreaterThanOrEqualTo: textEntered)
        .get();
    setState(() {
      postdocumentList;
    });
  }

  TextEditingController searchController = TextEditingController();
  String capitalize(String textEntered) {
    if (textEntered.trim().isEmpty) {
      return "";
    } else {
      return "${textEntered[0].toUpperCase()}${textEntered.substring(1).toLowerCase()}";
    }
  }

  @override
  void initState() {
    _cnt3 = SingleValueDropDownController();
    selectedDepartment;
    readValue = addbox.read('saveValue');
    var selectValue = addbox.read('select');
    if (readValue == null || readValue == '') {
      readValue = '';
    } else {
      readValue = addbox.read('saveValue');
    }
    if (selectValue != null) {
      selectedRole = selectValue;
    }

    super.initState();
  }

  @override
  void dispose() {
    _cnt3.dispose();
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();
  var addbox = GetStorage();
  String? readValue = '';
  @override
  Widget build(BuildContext context) {
    var routeBox = GetStorage();
    var boxone = routeBox.read('routeBoxOne');
    var boxtwo = routeBox.read('routeBoxTwo');
    var editFieldOne = routeBox.read('selectedProduct');
    var editFieldTwo = routeBox.read('selectedTerm');
    var editFieldThree = routeBox.read('firstdob');
    var editFieldFour = routeBox.read('lastdob');
    var editFieldFive = routeBox.read('amount');
    var editFieldSix = routeBox.read('desired');
    var editFieldSeven = routeBox.read('measureAmount');
    var editFieldEight = routeBox.read('section');
    var editFieldNine = routeBox.read('shelf');
    var editFieldTen = routeBox.read('item');
    var editFieldEleven = routeBox.read('selectedContainer');
    var editFieldTwelve = routeBox.read('selectedMeasure');
    var editFieldThirteen = routeBox.read('selectedRoom');
    var ss = addbox.read("saveBox");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Product',
          style: TextStyle(fontSize: 20.w, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              addbox.remove('saveValue');
              addbox.remove('select');
              if (boxone == 'product') {
                Get.toNamed(home, arguments: HomeScreen(0));
                routeBox.remove('routeBoxOne');
                routeBox.remove('routeBoxTwo');
              } else if (boxtwo == 'addInventory') {
                Get.to(const InventoryAddScreen());
                routeBox.remove('routeBoxOne');
                routeBox.remove('routeBoxTwo');
              } else {
                Get.to(EditInventoryField(
                  editFieldOne,
                  editFieldTwo,
                  editFieldThree,
                  editFieldFour,
                  editFieldFive,
                  editFieldSix,
                  editFieldEleven,
                  editFieldSeven,
                  editFieldTwelve,
                  editFieldThirteen,
                  editFieldEight,
                  editFieldNine,
                  editFieldTen,
                ));

                routeBox.remove('selectedProduct');
                routeBox.remove('selectedTerm');
                routeBox.remove('firstdob');
                routeBox.remove('lastdob');
                routeBox.remove('amount');
                routeBox.remove('desired');
                routeBox.remove('measureAmount');
                routeBox.remove('section');
                routeBox.remove('shelf');
                routeBox.remove('item');
                routeBox.remove('selectedContainer');
                routeBox.remove('selectedMeasure');
                routeBox.remove('selectedRoom');
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText("ProductName"),
                  customTextField(
                      TextInputType.name,
                      false,
                      nameController
                        ..text = readValue!
                        ..selection = TextSelection.fromPosition(
                            TextPosition(offset: nameController.text.length)),
                      null,
                      context,
                      "Product Name must be greater than 3 characters",
                      (value) {}, onChanged: (val) {
                    readValue = nameController.text;
                    if (readValue!.length < 4 || readValue!.length > 3) {
                      setState(() {});
                    }
                  }),
                  if (readValue!.length > 3)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText("DeptCategory"),
                        Container(
                            width: double.infinity,
                            decoration: AppStyles.borderDecoration,
                            child: StreamBuilder(
                                stream:_firestore
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
                                  for (int i = 0;
                                      i < snapshot.data.docs.length;
                                      i++) {
                                    DocumentSnapshot snap =
                                        snapshot.data.docs[i];
                                    listOfRole.add(snap['depCategory']);
                                  }

                                  return Padding(
                                    padding: AppStyles.kRegularPadding,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField2(
                                        validator: (value) => value == null
                                            ? 'field required'
                                            : null,
                                        value: ss ?? selectedRole,
                                        items: listOfRole.map((document) {
                                          return DropdownMenuItem(
                                              value: document,
                                              child: Text(document));
                                        }).toList(),
                                        onChanged:
                                            // readValue == null || readValue == ''
                                            //     ? null
                                            //     :
                                            (val) {
                                          selectedRole = val as String;
                                          setState(() {});
                                        },
                                        decoration: const InputDecoration(
                                            border: InputBorder.none),
                                        searchController:
                                            depCategorySearchController,
                                        searchInnerWidget: TextFormField(
                                          controller:
                                              depCategorySearchController,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 16,
                                            ),
                                            hintText: 'Search for an item...',
                                            hintStyle:
                                                const TextStyle(fontSize: 12),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                        addNewbutton(() {
                          addbox.write('saveValue', nameController.text);
                          addbox.write('select', selectedRole);
                          Get.to(SelectDepartmentForProductScreen(
                              "AddNewProduct"));
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            cancelButton(
                              () {
                                if (boxone == 'product') {
                                  Get.toNamed(home, arguments: HomeScreen(0));
                                  // routeBox.remove('routeBoxOne');
                                  // routeBox.remove('routeBoxTwo');
                                  routeBox.erase();
                                } else if (boxtwo == 'addInventory') {
                                  Get.to(const InventoryAddScreen());
                                  // routeBox.remove('routeBoxOne');
                                  // routeBox.remove('routeBoxTwo');
                                  routeBox.erase();
                                } else {
                                  Get.to(EditInventoryField(
                                    editFieldOne,
                                    editFieldTwo,
                                    editFieldThree,
                                    editFieldFour,
                                    editFieldFive,
                                    editFieldSix,
                                    editFieldEleven,
                                    editFieldSeven,
                                    editFieldTwelve,
                                    editFieldThirteen,
                                    editFieldEight,
                                    editFieldNine,
                                    editFieldTen,
                                  ));

                                  routeBox.remove('selectedProduct');
                                  routeBox.remove('selectedTerm');
                                  routeBox.remove('firstdob');
                                  routeBox.remove('lastdob');
                                  routeBox.remove('amount');
                                  routeBox.remove('desired');
                                  routeBox.remove('measureAmount');
                                  routeBox.remove('section');
                                  routeBox.remove('shelf');
                                  routeBox.remove('item');
                                  routeBox.remove('selectedContainer');
                                  routeBox.remove('selectedMeasure');
                                  routeBox.remove('selectedRoom');
                                }
                              },
                            ),
                            TextButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _firestore
                                        .collection("all-data")
                                        .where("productName",
                                            isEqualTo: nameController
                                                .text.capitalizeFirst)
                                        .get()
                                        .then((snapshot) {
                                      var dd = snapshot.docs;
                                      if (dd.isEmpty) {
                                        _firestore
                                            .collection("all-data")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.email)
                                            .collection("my-data")
                                            .doc(nameController
                                                .text.capitalizeFirst)
                                            .set({
                                          "productName": nameController
                                              .text.capitalizeFirst,
                                          "deptCategory": selectedRole,
                                          "value": false,
                                          
                                        });
                                        _firestore
                                            .collection("all-data")
                                            .doc(nameController
                                                .text.capitalizeFirst)
                                            .set({
                                          "productName": nameController
                                              .text.capitalizeFirst,
                                          "deptCategory": selectedRole,
                                          "value": false,
                                          'num':1
                                          
                                        }).whenComplete(() {
                                          Fluttertoast.showToast(
                                              msg: "Successfully Uploaded");
                                          nameController.clear();
                                          selectedRole = null;
                                          if (boxone == 'product') {
                                            Get.toNamed(home,
                                                arguments: HomeScreen(0));
                                            //
                                            // routeBox.remove('routeBoxOne');
                                            // routeBox.remove('routeBoxTwo');
                                            // routeBox.write('routeBoxOne', '');
                                            // routeBox.write('routeBoxTwo', '');
                                            // routeBox.remove("saveBox");
                                            // nameController.clear();
                                            // selectedRole = null;
                                            routeBox.erase();
                                          } else if (boxtwo == 'addInventory') {
                                            Get.to(const InventoryAddScreen());
                                            //
                                            // routeBox.remove('routeBoxOne');
                                            // routeBox.remove('routeBoxTwo');
                                            // routeBox.write('routeBoxOne', '');
                                            // routeBox.write('routeBoxTwo', '');
                                            // routeBox.remove("saveBox");
                                            // nameController.clear();
                                            // selectedRole = null;
                                            routeBox.erase();
                                          } else {
                                            Get.to(EditInventoryField(
                                              editFieldOne,
                                              editFieldTwo,
                                              editFieldThree,
                                              editFieldFour,
                                              editFieldFive,
                                              editFieldSix,
                                              editFieldEleven,
                                              editFieldSeven,
                                              editFieldTwelve,
                                              editFieldThirteen,
                                              editFieldEight,
                                              editFieldNine,
                                              editFieldTen,
                                            ));
                                            routeBox.remove('selectedProduct');
                                            routeBox.remove('selectedTerm');
                                            routeBox.remove('firstdob');
                                            routeBox.remove('lastdob');
                                            routeBox.remove('amount');
                                            routeBox.remove('desired');
                                            routeBox.remove('measureAmount');
                                            routeBox.remove('section');
                                            routeBox.remove('shelf');
                                            routeBox.remove('item');
                                            routeBox
                                                .remove('selectedContainer');
                                            routeBox.remove('selectedMeasure');
                                            routeBox.remove('selectedRoom');
                                          }
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Already Added");

                                        if (boxone == 'product') {
                                          Get.toNamed(home,
                                              arguments: HomeScreen(0));
                                          //
                                          // routeBox.remove('routeBoxOne');
                                          // routeBox.remove('routeBoxTwo');
                                          // routeBox.write('routeBoxOne', '');
                                          // routeBox.write('routeBoxTwo', '');
                                          // routeBox.remove("saveBox");
                                          // nameController.clear();
                                          // selectedRole = null;
                                          routeBox.erase();
                                        } else if (boxtwo == 'addInventory') {
                                          Get.to(const InventoryAddScreen());
                                          //
                                          // routeBox.remove('routeBoxOne');
                                          // routeBox.remove('routeBoxTwo');
                                          // routeBox.write('routeBoxOne', '');
                                          // routeBox.write('routeBoxTwo', '');
                                          // routeBox.remove("saveBox");
                                          // nameController.clear();
                                          // selectedRole = null;
                                          routeBox.erase();
                                        } else {
                                          Get.to(EditInventoryField(
                                            editFieldOne,
                                            editFieldTwo,
                                            editFieldThree,
                                            editFieldFour,
                                            editFieldFive,
                                            editFieldSix,
                                            editFieldEleven,
                                            editFieldSeven,
                                            editFieldTwelve,
                                            editFieldThirteen,
                                            editFieldEight,
                                            editFieldNine,
                                            editFieldTen,
                                          ));
                                          routeBox.remove('selectedProduct');
                                          routeBox.remove('selectedTerm');
                                          routeBox.remove('firstdob');
                                          routeBox.remove('lastdob');
                                          routeBox.remove('amount');
                                          routeBox.remove('desired');
                                          routeBox.remove('measureAmount');
                                          routeBox.remove('section');
                                          routeBox.remove('shelf');
                                          routeBox.remove('item');
                                          routeBox.remove('selectedContainer');
                                          routeBox.remove('selectedMeasure');
                                          routeBox.remove('selectedRoom');
                                        }
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
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectDepartmentForProductScreen extends StatefulWidget {
  var pageController;
  SelectDepartmentForProductScreen(this.pageController);

  @override
  State<SelectDepartmentForProductScreen> createState() =>
      _SelectDepartmentForProductScreenState();
}

class _SelectDepartmentForProductScreenState
    extends State<SelectDepartmentForProductScreen> {
  String? selectedDepartment;
  List listOfDepartment = [];
  final _formkey = GlobalKey<FormState>();
  String? selectedCategory;
  List listOfCategory = [];
  Stream<QuerySnapshot>? postdocumentList;
  TextEditingController departmentSearchController = TextEditingController();
  TextEditingController categorySearchController = TextEditingController();
  var saveBox = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        title: 'Department',
        onPress: () {
          if (widget.pageController == "ProductEditScreen") {
            Get.back();
          } else {
            Get.to(AddNewProductForProductScreen(''));
          }
        },
      ),
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
                  titleText("Department"),
                  Container(
                    width: double.infinity,
                    decoration: AppStyles.borderDecoration,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('department')
                            .orderBy('dep', descending: false)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          listOfDepartment.clear();
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            listOfDepartment.add(snap['dep']);
                          }
                          return Padding(
                            padding: AppStyles.kRegularPadding,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                items: listOfDepartment.map((document) {
                                  return DropdownMenuItem(
                                      value: document, child: Text(document));
                                }).toList(),
                                onChanged: (val) {
                                  selectedDepartment = val as String;
                                  setState(() {});
                                },
                                dropdownMaxHeight: 400,
                                value: selectedDepartment,
                                searchController: departmentSearchController,
                                searchInnerWidget: TextFormField(
                                  controller: departmentSearchController,
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
                        }),
                  ),
                  if (selectedDepartment != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText("Category"),
                        Container(
                          width: double.infinity,
                          decoration: AppStyles.borderDecoration,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('department')
                                  .doc(selectedDepartment)
                                  .collection(selectedDepartment!)
                                  .orderBy('cat', descending: false)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                listOfCategory.clear();
                                for (int i = 0;
                                    i < snapshot.data.docs.length;
                                    i++) {
                                  DocumentSnapshot snap = snapshot.data.docs[i];
                                  listOfCategory.add(snap['cat']);
                                }

                                return Padding(
                                  padding: AppStyles.kRegularPadding,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      validator: (value) => value == null
                                          ? 'field required'
                                          : null,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none),
                                      items: listOfCategory.map((document) {
                                        return DropdownMenuItem(
                                            value: document,
                                            child: Text(document));
                                      }).toList(),
                                      onChanged: (val) {
                                        selectedCategory = val as String;
                                        setState(() {});
                                      },
                                      dropdownMaxHeight: 400,
                                      value: selectedCategory,
                                      searchController:
                                          categorySearchController,
                                      searchInnerWidget: TextFormField(
                                        controller: categorySearchController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 16,
                                          ),
                                          hintText: 'Search for an item...',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            cancelButton(() {
                              if (widget.pageController ==
                                  "ProductEditScreen") {
                                Get.back();
                              } else {
                                Get.to(AddNewProductForProductScreen(''));
                              }
                            }),
                            TextButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    FirebaseFirestore.instance
                                        .collection("department-category")
                                        .doc(
                                            '$selectedDepartment ,$selectedCategory')
                                        .set({
                                      'depCategory':
                                          '$selectedDepartment ,$selectedCategory'
                                    }).whenComplete(() {
                                      saveBox.write("saveBox",
                                          '$selectedDepartment ,$selectedCategory');
                                      Fluttertoast.showToast(
                                          msg: "New DeptCategory Created");
                                      if (widget.pageController ==
                                          "ProductEditScreen") {
                                        Get.back();
                                      } else {
                                        Get.to(
                                            AddNewProductForProductScreen(''));
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
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
