import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tamplates_app/const/app_strings.dart';
import 'package:tamplates_app/ui/route/route.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import 'package:tamplates_app/ui/widgets/app_buttons.dart';
import 'package:tamplates_app/ui/widgets/custom_appbar.dart';
import 'package:tamplates_app/ui/widgets/text_from_field.dart';

import '../bottom_nav_pages/home/home_screen.dart';

class UserScreen extends StatefulWidget {
  var email;
  UserScreen(this.email);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  // late SingleValueDropDownController _cnt;
  // late SingleValueDropDownController _cnt2;

  var _image;
  var pickedImage;
  var url;
  String role = 'Select Role';
  String type = 'Membership Type';

  pickGalleryImage() async {
    final ImagePicker _picker = ImagePicker();
    _image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    setState(() {
      pickedImage = _image;
    });
  }

  uploadProfileImageToStroage() async {
    try {
      DateTime now = DateTime.now();
      File imageFile = File(pickedImage!.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      UploadTask uploadTask = storage
          .ref('users-profile-images')
          .child(now.toString())
          .putFile(imageFile);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        url = imageUrl;
      });
      return url;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      Get.back();
    }
  }

  var box = GetStorage();
  @override
  void initState() {
    // _cnt = SingleValueDropDownController();
    // _cnt2 = SingleValueDropDownController();

    box.write("verify", true);

    super.initState();
  }

  @override
  void dispose() {
    // _cnt.dispose();
    // _cnt2.dispose();
    var box = GetStorage();
    box.erase();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(
          title: "User",
          onPress: () {
            Get.toNamed(signIn);
          },
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 25.w, right: 25.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: pickedImage == null
                        ? IconButton(
                            onPressed: () => pickGalleryImage(),
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 30.w,
                            ),
                          )
                        : CircleAvatar(
                            radius: 100.r,
                            backgroundImage: FileImage(
                              File(pickedImage!.path),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    AppString.firstName,
                    style: AppStyles.myTextStyle,
                  ),
                  customTextField(TextInputType.name, false,
                      _firstnameController, null, context, "", (value) {
                    if (value!.isEmpty) {
                      return "name can't be empty";
                    } else {
                      return null;
                    }
                  }),
                  Text(AppString.lastName, style: AppStyles.myTextStyle),
                  customTextField(TextInputType.name, false,
                      _lastnameController, null, context, "", (value) {
                    if (value!.isEmpty) {
                      return "name can't be empty";
                    } else {
                      return null;
                    }
                  }),
                  Text(AppString.phone, style: AppStyles.myTextStyle),
                  customTextField(TextInputType.number, false, _phoneController,
                      null, context, "", (value) {
                    if (value!.isEmpty) {
                      return "phone number can't be empty";
                    } else if (value.length < 11) {
                      return "can't be more then 11";
                    } else {
                      return null;
                    }
                  }),
                  Text(AppString.role, style: AppStyles.myTextStyle),
                  Container(
                    width: double.infinity,
                    decoration: AppStyles.borderDecoration,
                    child: Padding(
                      padding: AppStyles.kRegularPadding,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          hint: Text(
                            role,
                          ),
                          items: <String>['Admin', 'Manager', 'User']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              role = val!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(AppString.membershiptype, style: AppStyles.myTextStyle),
                  Container(
                    width: double.infinity,
                    decoration: AppStyles.borderDecoration,
                    child: Padding(
                      padding: AppStyles.kRegularPadding,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField<String>(
                          validator: (value) =>
                              value == null ? 'field required' : null,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          hint: Text(
                            type,
                          ),
                          items: <String>['Premium', 'Basic', 'Standerd']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              type = val!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      cancelButton(
                        () => Get.back(),
                      ),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              uploadProfileImageToStroage().whenComplete(() {
                                var collectionReference = FirebaseFirestore
                                    .instance
                                    .collection("all-user")
                                    .doc(widget.email ??
                                        '${_firstnameController.text}@gmail.com');
                                collectionReference.set({
                                  'email': widget.email ??
                                      '${_firstnameController.text}@gmail.com',
                                  "first_name": _firstnameController.text,
                                  "last_name": _lastnameController.text,
                                  "phone_number": _phoneController.text,
                                  "img": url,
                                  "role": role,
                                  "type": type
                                });
                                Fluttertoast.showToast(
                                    msg: "Successfully Uploaded");
                              });
                              var box = GetStorage();
                              await box.write("user", true);
                              Get.toNamed(home, arguments: HomeScreen(0));
                            }
                          },
                          child: Text(
                            AppString.save,
                            style: AppStyles.titleStyle,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
