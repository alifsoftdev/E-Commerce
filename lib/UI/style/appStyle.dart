import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {

  InputDecoration textFieldDecoration(String hint,icon)=> InputDecoration(

    hintText: hint,
    suffix: icon,
    hintStyle: TextStyle(
      fontSize: 15.sp
    ),
    
  );
  progressDialog(context)=>showDialog(context: context, builder: (_)=>Dialog(
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        CircularProgressIndicator(),
        Text('Processing')
        ],
      ),
    ),
  ));
}