import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/UI/route/route.dart';
import 'package:e_commerce/const/appColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../widget/fullWightButton.dart';
import '../../widget/textfield.dart';

class AuthForm extends StatefulWidget {
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  List<String> gender = ["Male", "Female", "Other"];

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "dob":_dobController.text,
      "gender":_genderController.text,
      "age":_ageController.text,
    }).then((value) => Get.toNamed(bottomNavController)).catchError((error)=>print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 80.r, right: 30.r, left: 30.r),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Submit the form to continue',
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.bright_Pink),
            ),
            Text(
              'We will not share your information with anyone',
              style: TextStyle(color: Colors.black54, fontSize: 12.sp),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 80.h,
            ),
            customTextFormField(
                _nameController, 'Full Name', TextInputType.emailAddress),
            SizedBox(
              height: 20.h,
            ),
            customTextFormField(
                _phoneController, 'Phone Number', TextInputType.phone),
            SizedBox(
              height: 20.h,
            ),
            customTextFormField(_ageController, 'Enter your age', TextInputType.number),
            SizedBox(
              height: 20.h,
            ),
            TextField(
                  controller: _dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "date of birth",
                    suffixIcon: IconButton(
                      onPressed: () => _selectDateFromPicker(context),
                      icon: Icon(Icons.calendar_today_outlined),
                    ),
                  ),
                ),
            SizedBox(
              height: 20.h,
            ),
            TextField(
                  controller: _genderController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "choose your gender",
                    suffixIcon: DropdownButton<String>(
                      items: gender.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                          onTap: () {
                            setState(() {
                              _genderController.text = value;
                            });
                          },
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
            SizedBox(
              height: 60.h,
            ),
            FullWightButton('Continue', ()=>sendUserDataToDB())
              ]
              )
        ),
      ),
    );
  }
}
