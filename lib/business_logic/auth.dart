import 'package:e_commerce/UI/route/route.dart';
import 'package:e_commerce/const/appColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class Aouth {
  final box = GetStorage();

  Future signUp(String email, String password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var authCredential = userCredential.user;
    
      if (authCredential!.uid.isNotEmpty) {
        Fluttertoast.showToast(msg: 'Ragistration Successfull');
        box.write('uid', authCredential.uid);
       Get.toNamed(authForm);
      } else {
        Fluttertoast.showToast(
            msg: "Sign Up Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.black,
            textColor: AppColor.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "weak-password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:  AppColor.black,
            textColor:  AppColor.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "email-already-in-use",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor:  AppColor.black,
            textColor:  AppColor.white,
            fontSize: 16.0);
      }
    }
  }

  Future signIn(email, password, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      var authCredential = userCredential.user;
      print(authCredential);
      if (authCredential!.uid.isNotEmpty) {
        Get.toNamed(bottomNavController);
      } else {
        Fluttertoast.showToast(
            msg: "Sign Up Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor:  AppColor.black,
            textColor: AppColor.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: "weak-password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.black,
            textColor: AppColor.white,
            fontSize: 16.0);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "email-already-in-use",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.black,
            textColor: AppColor.white,
            fontSize: 16.0);
      }
    }
  }

  Future signOut() async {
    try {
      var _auth;
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Future signInWithGoogle(context) async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   UserCredential _userCredential =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   User? _user = _userCredential.user;

  //   if (_user!.uid.isNotEmpty) {
  //     Get.toNamed(home);
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: "Something is wrong",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: AppColor.black,
  //         textColor: AppColor.white,
  //         fontSize: 16.0);
  //   }
  // }
}