import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamplates_app/ui/styles/styles.dart';
import '../../const/app_colors.dart';
import '../../const/app_strings.dart';

Widget addNewbutton(onPress) {
  return InkWell(
    onTap: onPress,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Icon(
            Icons.edit_note,
            color: AppColors.greenAccent,
            size: 20.w,
          ),
          Text(
            "Add new",
            style: TextStyle(fontSize: 20.sp, color: AppColors.greenAccent),
          )
        ],
      ),
    ),
  );
}

Widget cancelButton(ontap) {
  return TextButton(
      onPressed: ontap,
      child: Text(
        AppString.cancel,
        style: AppStyles.titleStyle,
      ));
}


class VioletButton extends StatelessWidget {
  String title;
  final Function onAction;
  VioletButton(this.title, this.onAction);

  //RxBool _value = false.obs;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap: () {
         // _value.value = true;
          onAction();
        },
        child: Container(
          height: 48.h,
          decoration: BoxDecoration(
            color: AppColors.violetColor,
            borderRadius: BorderRadius.all(Radius.circular(5.r)),
          ),
          child:
          // _value == false ?
            Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17.sp,
                      color: Colors.white,
                    ),
                  ),
                )
              // : Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Please Wait",
              //         style: TextStyle(
              //           fontWeight: FontWeight.w500,
              //           fontSize: 17.sp,
              //           color: Colors.white,
              //         ),
              //       ),
              //       SizedBox(
              //         width: 10.w,
              //       ),
              //       Transform.scale(
              //           scale: 0.4,
              //           child: const CircularProgressIndicator(
              //             color: Colors.white,
              //           )),
              //     ],
              //   ),
        ),
      )
    ;
  }
}
