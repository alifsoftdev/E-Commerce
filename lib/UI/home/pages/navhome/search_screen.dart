import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../const/appColor.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  TextEditingController _searchController = TextEditingController();
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      inputText = value;
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    fillColor: Colors.white,
                    hintText: 'Search products here',
                    contentPadding:
                        EdgeInsets.only(left: 14.w, bottom: 8.h, top: 8.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.bright_Pink),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .where("product-name",isEqualTo: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        Fluttertoast.showToast(
                            msg: "Something went wrong",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColor.black,
                            textColor: AppColor.white,
                            fontSize: 16.0);
                      }
                      if (snapshot.connectionState==ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String,dynamic> data=document.data() as Map<String, dynamic>;
                          return Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text(data['product-name']),
                              subtitle: Text(data['subtitle']),
                              leading: Container(
                                width: 80.w,
                                child: Image.network(data['product-img'][0])),
                              trailing: Text(data['product-price']+' TK'),
                            ),
                          );
                        } ).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
