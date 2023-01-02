import 'package:flutter/material.dart';
import 'package:tamplates_app/ui/styles/styles.dart';

Widget titleText(title) {
  return Padding(
    padding: const EdgeInsets.only(bottom:8.0,top: 7),
    child: Text(
      title,
      style: AppStyles.titleStyle,
    ),
  );
}
