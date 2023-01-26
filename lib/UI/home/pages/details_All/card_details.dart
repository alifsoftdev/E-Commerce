// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../../../const/appColor.dart';

// class Card_details extends StatelessWidget {
//     var _products;
//   Card_details(this._products);


//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: AppColor.bgColor,
//         appBar: AppBar(
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () => Get.back(),
//               icon: Icon(
//                 Icons.arrow_circle_left,
//                 color: AppColor.bright_Pink,
//                 size: 30,
//               )),
//           title: Text(
//             'Product Details',
//             style: TextStyle(
//                 color: AppColor.bright_Pink,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w400),
//           ),
//           centerTitle: true,
//           backgroundColor: AppColor.bgColor,
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CarouselSlider(
//                     items: _products['product-img']
//                         .map((item) => Container(
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: NetworkImage(item),
//                                       fit: BoxFit.cover)),
//                             ))
//                         .toList(),
//                     options: CarouselOptions(
//                       height: 170,
//                       viewportFraction: 0.8,
//                       initialPage: 0,
//                       enableInfiniteScroll: true,
//                       reverse: false,
//                       autoPlayInterval: Duration(seconds: 3),
//                       autoPlayAnimationDuration: Duration(milliseconds: 700),
//                       autoPlayCurve: Curves.fastOutSlowIn,
//                       enlargeCenterPage: true,
//                       enlargeFactor: 0.3,
//                       onPageChanged: (val, carouselPageChangedreason) {

//                       },
//                       scrollDirection: Axis.horizontal,
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "Name: ${_products["product-name"]}",
//                   style:
//                       TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "Product Subtitle: ${_products["product-subtitle"]}",
//                   style:
//                       TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "Product Price: ${_products["product-price"]}" + " TK",
//                   style:
//                       TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   _products["product-description"],
//                   style:
//                       TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400),
//                 ),
//                 SizedBox(
//                   height: 20.h,
//                 ),
                
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
