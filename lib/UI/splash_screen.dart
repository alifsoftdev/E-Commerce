import 'package:e_commerce/UI/route/route.dart';
import 'package:e_commerce/const/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  final box=GetStorage();

Future chooseScreen()async{
  var userId=box.read('uid');
  if (userId==null) {
    Get.toNamed(signIn);
  }else{
    Get.toNamed(bottomNavController);
  }
}

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),()=>chooseScreen());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.white,
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png",scale: 8,),
              SizedBox(height: 20.h,),
              CircularProgressIndicator(
                color: AppColor.bright_Pink
              )
            ],
          ),
        ),
      ),
    );
  }
}