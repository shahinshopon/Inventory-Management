import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamplates_app/const/app_colors.dart';

Widget drawerItemMobile(icon, title,onTap) {
  return Padding(
    padding: EdgeInsets.only(top: 30.h),
    child: InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon,size: 25, color: AppColors.black),
          SizedBox(width:25.w,),
          Text(title,style: TextStyle(fontSize:20.sp,color:Colors.black54),),
        ],
      ),
    )
  );
}