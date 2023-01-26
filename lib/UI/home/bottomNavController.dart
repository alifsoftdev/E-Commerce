import 'package:e_commerce/UI/home/pages/account.dart';
import 'package:e_commerce/UI/home/pages/addCard.dart';
import 'package:e_commerce/UI/home/pages/favorite.dart';
import 'package:e_commerce/UI/home/pages/navhome/navHome.dart';
import 'package:e_commerce/const/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavController extends StatelessWidget {
  RxInt _currentIndex = 0.obs;

  final _pages = [NavHome(), FavouritePage(), Add_to_Card(), Account()];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => _currentIndex.value = value,
          currentIndex: _currentIndex.value,
          selectedItemColor: AppColor.black,
          selectedLabelStyle: TextStyle(
              fontSize: 15, color: AppColor.black, fontWeight: FontWeight.w500),
          elevation: 10,
          
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.sp, color: AppColor.bright_Pink),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite,
                    size: 30.sp, color: AppColor.bright_Pink),
                label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,
                    size: 30.sp, color: AppColor.bright_Pink),
                label: "Add"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 30.sp,
                color: AppColor.bright_Pink,
              ),
              label: "Account",
            ),
          ],
        ),
        body: _pages[_currentIndex.value],
      ),
    );
  }
}
