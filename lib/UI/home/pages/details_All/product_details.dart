import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/widget/fullWightButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../const/appColor.dart';

class Product_Details extends StatelessWidget {
  var _product;
  Product_Details(this._product);

  //add to card
  Future addToCard() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('card-add-data');
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": _product["product-name"],
      "subtitle": _product["product-subtitle"],
      "price": _product["product-price"],
      "description": _product["product-description"],
      "img": _product["product-img"],
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.black,
          textColor: Colors.white,
          fontSize: 13.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Added Failed $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.black,
          textColor: Colors.white,
          fontSize: 13.0);
    });
  }

  //add to favourite
  addtoFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users-favourite-data');
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": _product["product-name"],
      "subtitle": _product["product-subtitle"],
      "price": _product["product-price"],
      "description": _product["product-description"],
      "img": _product["product-img"],
    }).whenComplete(() {
      Fluttertoast.showToast(
          msg: "Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.black,
          textColor: Colors.white,
          fontSize: 13.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Added Failed $error",
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_circle_left,
                color: AppColor.bright_Pink,
                size: 30,
              )),
          title: Text(
            'Product Details',
            style: TextStyle(
                color: AppColor.bright_Pink,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          actions: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favourite-data")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .where("img", isEqualTo: _product['product-img'])
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("");
                }
                return IconButton(
                  onPressed: () => snapshot.data.docs.length == 0
                      ? addtoFavourite()
                      : Fluttertoast.showToast(
                          msg: "Already Added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.SNACKBAR,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColor.black,
                          textColor: Colors.white,
                          fontSize: 13.0),
                  icon: snapshot.data.docs.length == 0
                      ? Icon(
                          Icons.favorite_outline,
                          color:AppColor.bright_Pink,size: 30,
                        )
                      : Icon(
                          Icons.favorite,
                          color: AppColor.bright_Pink,size: 30,
                        ),
                );
              },
            ),
          ],
          centerTitle: true,
          backgroundColor: AppColor.bgColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: _product['product-img']
                        .map<Widget>((item) => Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover)),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 170,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 700),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (val, carouselPageChangedreason) {
                       
                      },
                      scrollDirection: Axis.horizontal,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Name: ${_product["product-name"]}",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Product Subtitle: ${_product["product-subtitle"]}",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Product Price: ${_product["product-price"]}" + " TK",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Description: ${_product["product-description"]}",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FullWightButton("Add to Card", () => addToCard())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
