import 'package:e_commerce/UI/auth_screen/authForm.dart';
import 'package:e_commerce/UI/home/pages/details_All/card_details.dart';
import 'package:e_commerce/UI/home/pages/details_All/favorite_dtails.dart';
import 'package:e_commerce/UI/home/pages/details_All/product_details.dart';
import 'package:e_commerce/UI/home/pages/navhome/search_screen.dart';
import 'package:get/get.dart';
import '../auth_screen/signIn.dart';
import '../auth_screen/signUp.dart';
import '../home/bottomNavController.dart';
import '../splash_screen.dart';

const String splash = '/Splash-Screen';
const String signIn = '/SignIn-Screen';
const String signUp = '/SignUp-Screen';
const String authForm = '/AuthForm-Screen';
const String bottomNavController = '/BottomNavController-Screen';
const String search_Screen = '/Sreach-Screen';
const String product_Details = '/Product_Details-Screen';
const String fav_Details = '/Fav_Details-Screen';

//controll our page route flow
List<GetPage> getpages = [
  GetPage(name: splash, page: () => Splash_Screen()),
  GetPage(name: signIn, page: () => SignIn_Screen()),
  GetPage(name: signUp, page: () => SignUp_Screen()),
  GetPage(name: authForm, page: () => AuthForm()),
  GetPage(name: bottomNavController, page: () => BottomNavController()),
  GetPage(name: search_Screen, page: () => Search_Screen()),
  GetPage(
    name: product_Details,
    page: () {
      Product_Details _detailsSCreen = Get.arguments;
      return _detailsSCreen;
    },
  ),
  GetPage(
    name: fav_Details,
    page: () {
      Favorite_Details _detailsSCreen = Get.arguments;
      return _detailsSCreen;
    },
  ),
];
