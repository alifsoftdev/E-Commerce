import 'package:e_commerce/UI/route/route.dart';
import 'package:e_commerce/business_logic/auth.dart';
import 'package:e_commerce/const/appColor.dart';
import 'package:e_commerce/widget/fullWightButton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUp_Screen extends StatefulWidget {
  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.bright_Pink,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 70.h, left: 20.w, right: 20.w, bottom: 40.h),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: AppColor.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                height: double.maxFinite,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.r),
                        topRight: Radius.circular(40.r))),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 50.h, left: 20.w, right: 20.w, bottom: 20.h),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wellcome Buddy!',
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.bright_Pink),
                          ),
                          Text(
                            'glad to see you back my buddy',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: 'email',
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: AppColor.bright_Pink,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: AppColor.bright_Pink),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          TextField(
                            controller: _passController,
                            obscureText: value,
                            decoration: InputDecoration(
                              hintText: 'password',
                              prefixIcon: Icon(
                                Icons.password,
                                color: AppColor.bright_Pink,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      value = !value;
                                    });
                                  },
                                  icon: value == true
                                      ? Icon(
                                          Icons.remove_red_eye,
                                          size: 25.sp,
                                          color: AppColor.bright_Pink,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 25.sp,
                                        )),
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: AppColor.bright_Pink),
                            ),
                          ),
                          SizedBox(
                            height: 80.h,
                          ),
                          FullWightButton(
                              'Sign Up',
                              () 
                              => Aouth().signUp(_emailController.text,
                                  _passController.text, context)
                              ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "Do you have an account? ",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                                children: [
                                  TextSpan(
                                    text: 'Sign In',
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColor.bright_Pink,
                                        fontWeight: FontWeight.w500),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.toNamed(signIn),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {},
                                //=> Aouth().signInWithGoogle(context),
                                child: Text(
                                  'Sign In With Google',
                                  style: TextStyle(
                                      fontSize: 15, 
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black54),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                'assets/google_icon.png',
                                scale: 6,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ],
          )),
    );
  }
}
