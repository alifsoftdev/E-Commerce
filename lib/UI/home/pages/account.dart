import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../const/appColor.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;
  TextEditingController? _addressController;

  updateData() {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(FirebaseAuth.instance.currentUser!.email).update({
      "name": _nameController!.text,
      "phone": _phoneController!.text,
      "age": _ageController!.text,
      "address": _addressController!.text,
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Update Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.black,
          textColor: Colors.white,
          fontSize: 13.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Update Failed $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.black,
          textColor: Colors.white,
          fontSize: 13.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users-form-data")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                TextFormField(
                  controller: _nameController =
                      TextEditingController(text: data['name']),
                ),
                TextFormField(
                  controller: _phoneController =
                      TextEditingController(text: data['phone'].toString()),
                ),
                TextFormField(
                  controller: _ageController =
                      TextEditingController(text: data['age']),
                ),
                TextFormField(
                  controller: _addressController =
                      TextEditingController(text: data['address']),
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () => updateData(), child: Text("Update"))
              ],
            );
          },
        ),
      )),
    );
  }
}
