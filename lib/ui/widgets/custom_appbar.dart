import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class customAppbar extends StatelessWidget implements PreferredSizeWidget {
  var title;
  final onPress;
  var action;
  customAppbar({Key? key, this.title,required this.onPress, this.action}) : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 20.w, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          onPressed: onPress,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      actions: action,
    );
  }
}
