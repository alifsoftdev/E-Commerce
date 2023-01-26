import 'package:e_commerce/const/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget FullWightButton(String text,dynamic onPress){
  return InkWell(
    onTap:onPress,
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.bright_Pink
      
      ),
      child: Center(child: Text(text,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: AppColor.white),)),
    ),
  );
}