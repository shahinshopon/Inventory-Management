// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamplates_app/const/app_colors.dart';

Widget customTextField(
  keyboardtype,
 bool obscuretext,
  controller,
  prefixicon,
  BuildContext context,
  hinttext,
  validate,{onChanged,initialValue}
) {
  return AspectRatio(
    aspectRatio: 4,
    child: Column(
      children: [
        Container(
          child: TextFormField(
            autofocus: false,
            validator: validate,
            obscureText: obscuretext,
            keyboardType: keyboardtype,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            controller: controller,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            onChanged: onChanged,
            initialValue: initialValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.black),
                borderRadius: BorderRadius.circular(10.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(10.r),
              ),
              hintText: hinttext,
              hintStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              errorStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ],
    ),
  );
}
