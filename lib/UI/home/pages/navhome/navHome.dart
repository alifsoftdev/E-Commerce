import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce/UI/home/pages/details_All/product_details.dart';
import 'package:e_commerce/UI/route/route.dart';
import 'package:e_commerce/const/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavHome extends StatefulWidget {
  @override
  State<NavHome> createState() => _NavHomeState();
}

class _NavHomeState extends State<NavHome> {
  List<String> _carouselImages = [];
  List _products = [];
  var _fireStoreInstance = FirebaseFirestore.instance;
  fetchCarouselImage() async {
    QuerySnapshot qn =
        await _fireStoreInstance.collection('benner_image').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]['img'],
        );
      }
    });
    return qn.docs;
  }

  fetchProduct() async {
    QuerySnapshot qn = await _fireStoreInstance.collection('products').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]['product-name'],
          "product-description": qn.docs[i]['description'],
          "product-price": qn.docs[i]['product-price'],
          "product-img": qn.docs[i]['product-img'],
          "product-subtitle": qn.docs[i]['subtitle'],

        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImage();
    fetchProduct();
    super.initState();
  }

  var dotPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'E-commerce',
              style: TextStyle(
                  color: AppColor.bright_Pink,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 40.w, right: 40.w, top: 10.h, bottom: 10.h),
              child: Container(
                height: 50.h,
                child: TextField(
                  style: TextStyle(fontSize: 17.sp, color: AppColor.black),
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: AppColor.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search products here',
                    contentPadding:
                        EdgeInsets.only(left: 14.w, bottom: 8.h, top: 8.h),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.bright_Pink),
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                  ),
                  onTap: () => Get.toNamed(search_Screen),
                ),
              ),
            ),
            CarouselSlider(
                items: _carouselImages
                    .map((item) => Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth)),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 170,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 700),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (val, carouselPageChangedreason) {
                    setState(() {
                      dotPosition = val;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                )),
            SizedBox(
              height: 10.h,
            ),
            DotsIndicator(
              dotsCount:
                  _carouselImages.length == 0 ? 1 : _carouselImages.length,
              position: dotPosition.toDouble(),
              decorator: DotsDecorator(
                  activeColor: AppColor.bright_Pink,
                  color: AppColor.bright_Pink.withOpacity(0.2),
                  spacing: EdgeInsets.all(4),
                  activeSize: Size(10, 10),
                  size: Size(8, 8)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Products',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: AppColor.bright_Pink,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
            Container(
              height: 180.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () => Get.toNamed(product_Details,
                            arguments: Product_Details(_products[index])),
                        child: Container(
                          width: 100.w,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Image.network(
                                    _products[index]["product-img"][0],
                                    fit: BoxFit.cover,
                                  )),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${_products[index]["product-name"]}",
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "Price:${_products[index]["product-price"]}" +
                                            " TK",
                                        style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, bottom: 10.h, left: 20.w, right: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Products',
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'View All',
                        style: TextStyle(
                            color: AppColor.bright_Pink,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 120.h,
            ),
          ],
        ),
      ),
    );
  }
}
