import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget customTextFormField(controller, String hintText, keyboardType) {
  return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black54)));
}